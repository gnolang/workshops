package gnoverflow

import (
	"std"
	"time"

	"gno.land/p/demo/avl"
)

type Question struct {
	ID       uint64
	Title    string
	Text     string
	Answers  []*Answer
	IsLocked bool
	Upvotes  avl.Tree

	Author    std.Address
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (q Question) GetAnswer(id uint64) *Answer {
	if len(q.Answers) == 0 {
		panic("question has no answers")
	}

	var (
		low  int
		mid  int
		high = len(q.Answers) - 1
	)

	// Use binary search to find the answer.
	for low <= high {
		mid = low + (high-low)/2
		if q.Answers[mid].ID == id {
			return q.Answers[mid]
		} else if q.Answers[mid].ID < id {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}

	panic("answer not found")
}

func PostQuestion(title, text string) uint64 {
	author := std.PrevRealm().Addr()
	questionID := uint64(questions.Size())
	question := &Question{
		ID:        questionID,
		Title:     title,
		Text:      text,
		Author:    author,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
	}

	question.Upvotes.Set(author.String(), struct{}{})

	// Add question to storage.
	if updated := questions.Set(questionID, question); updated {
		// This should never happen.
		panic("question ID already used")
	}

	return questionID
}

// UpdateQuestion updates a question's title and/or text.
func UpdateQuestion(id uint64, title, text string) {
	if title == "" && text == "" {
		panic("title or text must be provided")
	}

	caller := std.PrevRealm().Addr()
	question := getQuestion(id)
	if question.IsLocked && caller != moderator {
		panic("question locked by moderator")
	}

	if question.Author != caller && caller != moderator {
		panic("a question can only be updated by its author")
	}

	if title != "" {
		question.Title = title
	}

	if text != "" {
		question.Text = text
	}

	question.UpdatedAt = time.Now()
}

func UpvoteQuestion(questionID uint64) {
	question := getQuestion(questionID)
	upvote(&question.Upvotes)
	question.UpdatedAt = time.Now()
}

func upvote(upvotes *avl.Tree) {
	caller := std.PrevRealm().Addr()
	if upvotes.Has(caller.String()) {
		panic("already upvoted")
	}

	upvotes.Set(caller.String(), struct{}{})
}

func getQuestion(id uint64) *Question {
	value, ok := questions.Get(id)
	if !ok {
		panic("question does not exist")
	}

	var question *Question
	if question, ok = value.(*Question); !ok {
		panic("value should be type *Question")
	}

	return question
}
