package twitter

import (
	"time"
	
	"gno.land/p/demo/ufmt"
)

// TODO: Update this function to show upvotes and downvotes
func (p Post) String() string {
	return ufmt.Sprintf("Text: %s\n\nAuthor: %s\n\n Time: %s", p.text, p.author.String(), p.createdAt.Format(time.RFC822))
}

func Render(_ string) string {
	if len(posts) == 0 {
		return "No posts currently."
	}

	output := ""
	for _, post := range posts {
		output += ufmt.Sprintf("### Post #%d\n\n%s\n\n", post.id, post.String())
	}

	return output
}