package gnoverflow

import "strings"

func Render(_ string) string {
	var sb strings.Builder

	sb.WriteString("# Welcome to Gnoverflow!\n\n")
	if questions.Size() == 0 {
		sb.WriteString("No questions yet. Be the first to ask!\n")
		return sb.String()
	}

	// Iterate over questions, most recent first.
	questions.ReverseIterate(0, 0, func(_ uint64, value interface{}) bool {
		_, ok := value.(*Question)
		if !ok {
			panic("value should have type of *Question")
		}

		// TODO: Render questions using markdown syntax.

		// Return true to terminate iteration.
		return false
	})

	return sb.String()
}
