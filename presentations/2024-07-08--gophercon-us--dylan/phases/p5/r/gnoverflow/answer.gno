package gnoverflow

import (
	"std"
	"time"

	"gno.land/p/demo/avl"
)

var nextAnswerID uint64

// Answer represents an answer to question.
type Answer struct {
	ID         uint64
	QuestionID uint64
	Text       string
	IsLocked   bool
	Upvotes    avl.Tree

	Author    std.Address
	CreatedAt time.Time
	UpdatedAt time.Time
}

// PostAnswer creates an answer to a question and returns its ID.
func PostAnswer(questionID uint64, text string) uint64 {
	question := getQuestion(questionID)
	if question.IsLocked {
		panic("cannot answer locked question")
	}

	author := std.PrevRealm().Addr()
	answerID := nextAnswerID
	answer := &Answer{
		ID:         answerID,
		QuestionID: questionID,
		Text:       text,
		Author:     author,
		CreatedAt:  time.Now(),
		UpdatedAt:  time.Now(),
	}

	answer.Upvotes.Set(author.String(), struct{}{})
	question.Answers = append(question.Answers, answer)

	nextAnswerID++
	return answerID
}

// UpdateAnswer can modify the text of an answer.
func UpdateAnswer(id, questionID uint64, text string) {
	if text == "" {
		panic("text must be provided")
	}

	caller := std.PrevRealm().Addr()
	question := getQuestion(questionID)
	answer := question.GetAnswer(id)
	if answer.IsLocked && caller != moderator {
		panic("answer locked by moderator")
	}

	if answer.Author != caller && caller != moderator {
		panic("an answer can only be updated by its author")
	}

	answer.Text = text
	answer.UpdatedAt = time.Now()
}

func UpvoteAnswer(answerID, questionID uint64) {
	question := getQuestion(questionID)
	answer := question.GetAnswer(answerID)
	upvote(&answer.Upvotes)
	answer.UpdatedAt = time.Now()
}
