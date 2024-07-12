package gnoverflow

import "strings"

func Render(_ string) string {
	var sb strings.Builder

	sb.WriteString("# Welcome to Gnoverflow!\n")
	if questions.Size() == 0 {
		sb.WriteString("No questions yet. Be the first to ask!\n")
		return sb.String()
	}

	// Iterate over questions, most recent first.
	questions.ReverseIterate(0, 0, func(_ uint64, value interface{}) bool {
		question, ok := value.(*Question)
		if !ok {
			panic("value should have type of *Question")
		}

		sb.WriteString("---\n## " + question.Title + "\n\n")
		sb.WriteString(question.Text + "\n\n")
		sb.WriteString("**Author: " + question.Author.String() + "**\n\n")

		// TODO: Render question answers

		// Return true to terminate iteration.
		return false
	})

	return sb.String()
}
