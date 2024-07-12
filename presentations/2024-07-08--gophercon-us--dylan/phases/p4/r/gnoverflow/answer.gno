package gnoverflow

import (
	"std"
	"time"
)

var nextAnswerID uint64

// Answer represents an answer to question.
type Answer struct {
	ID         uint64
	QuestionID uint64
	Text       string

	Author    std.Address
	CreatedAt time.Time
	UpdatedAt time.Time
}

// PostAnswer creates an answer to a question and returns its ID.
func PostAnswer(questionID uint64, text string) uint64 {
	question := getQuestion(questionID)
	answerID := nextAnswerID
	question.Answers = append(
		question.Answers,
		&Answer{
			ID:         answerID,
			QuestionID: questionID,
			Text:       text,
			Author:     std.PrevRealm().Addr(),
			CreatedAt:  time.Now(),
			UpdatedAt:  time.Now(),
		},
	)

	nextAnswerID++
	return answerID
}

// UpdateAnswer can modify the text of an answer.
func UpdateAnswer(id, questionID uint64, text string) {
	if text == "" {
		panic("text must be provided")
	}

	author := std.PrevRealm().Addr()
	question := getQuestion(questionID)
	answer := question.GetAnswer(id)
	if answer.Author != author {
		panic("an answer can only be updated by its author")
	}

	answer.Text = text
	answer.UpdatedAt = time.Now()
}
