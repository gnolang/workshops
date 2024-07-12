package gnoverflow

import (
	"strconv"
	"strings"
)

func Render(path string) string {
	if path != "" {
		return renderRoute(path)
	}

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

		idString := strconv.FormatUint(question.ID, 10)
		sb.WriteString("---\n## ")
		sb.WriteString("[" + question.RenderTitle() + "](/r/gc24/gnoverflow:questions/" + idString + ")\n\n")

		// sb.WriteString(question.Text + "\n\n")
		// sb.WriteString("**Author: " + question.Author.String() + "**\n\n")

		// No answers to render; continue iteration.
		if len(question.Answers) == 0 {
			return false
		}

		sb.WriteString("### Answers\n\n")
		for i, answer := range question.Answers {
			sb.WriteString("**Answer by " + answer.Author.String() + " - Upvotes: " + strconv.Itoa(answer.Upvotes.Size()))
			if answer.IsLocked {
				sb.WriteString(" (locked)")
			}

			sb.WriteString("**\n\n")
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

func renderRoute(path string) string {
	if strings.HasPrefix(path, "questions/") {
		parts := strings.Split(path, "/")
		if len(parts) != 2 {
			return "404 Not Found"
		}

		questionID, err := strconv.Atoi(parts[1])
		if err != nil {
			return "Invalid question ID: " + parts[1]
		}

		question := getQuestion(uint64(questionID))
		return renderQuestion(question)
	}

	return "404 Not Found"
}

func renderQuestion(question *Question) string {
	var sb strings.Builder
	sb.WriteString("# " + question.Title + " | " + strconv.Itoa(question.Upvotes.Size()) + " Upvotes \n\n")
	sb.WriteString(question.Text + "\n\n")
	sb.WriteString("**Author: " + question.Author.String() + "**\n\n")
	if len(question.Bounty) != 0 {
		sb.WriteString("**Bounty: " + question.Bounty.String() + "**\n\n")
	}

	sb.WriteString("## Answers\n\n")
	for _, answer := range question.Answers {
		sb.WriteString(renderAnswer(answer))
	}

	return sb.String()
}

func renderAnswer(answer *Answer) string {
	var sb strings.Builder
	sb.WriteString("### [" + answer.Author.String() + " | " + strconv.Itoa(answer.Upvotes.Size()) +
		" Upvotes](/r/gc24/gnoverflow:answers/" + strconv.FormatUint(answer.ID, 10) + ")\n\n")
	sb.WriteString(answer.Text + "\n\n")
	sb.WriteString("Answered by " + answer.Author.String() + "\n\n")

	return sb.String()
}
