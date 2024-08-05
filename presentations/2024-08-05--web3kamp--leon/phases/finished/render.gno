package twitter

import (
	"time"
	
	"gno.land/p/demo/ufmt"
)

func (p Post) String() string {
	return ufmt.Sprintf("Text: %s\n\nAuthor: %s\n\n Time: %s\n\nUp: %d, Down: %d\n\nTotal tips: %dugnot", p.text, p.author.String(), p.createdAt.Format(time.RFC822), p.upvotes, p.downvotes, p.tipTotal)
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