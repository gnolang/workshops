package gnoverflow

import (
	"std"
	"time"
)

type Question struct {
	ID    uint64
	Title string
	Text  string

	Author    std.Address
	CreatedAt time.Time
	UpdatedAt time.Time
}

func PostQuestion(title, text string) uint64 {
	questionID := uint64(questions.Size())
	question := &Question{
		ID:        questionID,
		Title:     title,
		Text:      text,
		Author:    std.PrevRealm().Addr(),
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
	}

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

	author := std.PrevRealm().Addr()
	question := getQuestion(id)
	if question.Author != author {
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
