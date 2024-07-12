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

		// No answers to render; continue iteration.
		if len(question.Answers) == 0 {
			return false
		}

		sb.WriteString("### Answers\n\n")
		for i, answer := range question.Answers {
			sb.WriteString("**Answer by " + answer.Author.String() + "**\n\n")
			sb.WriteString(answer.Text + "\n\n")

			// Separate answers by horizontal rule, but not for the last answer
			// because each question is prefixed by a horizontal rule.
			if i != len(question.Answers)-1 {
				sb.WriteString("---\n\n")
			}
		}

		// Return true to terminate iteration.
		return false
	})

	return sb.String()
}
