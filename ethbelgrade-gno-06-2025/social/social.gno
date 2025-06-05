package social

import (
	"std"
	"strconv"
	"time"

	"gno.land/p/demo/ufmt"
)

var posts []*Post

type Post struct {
	Text      string
	Author    string
	CreatedAt time.Time
}

func CreatePost(text string) {
	p := &Post{
		Text:      text,
		Author:    std.PreviousRealm().Address().String(),
		CreatedAt: time.Now(),
	}

	posts = append(posts, p)
}

func (p Post) String() string {
	return ufmt.Sprintf("Text: %s\n\nAuthor: %s\n\nDate: %s\n\n---\n", p.Text, p.Author, p.CreatedAt.Format("02-01-2006"))
}

func Render(_ string) string {
	out := "# Posts\n\n"

	if len(posts) == 0 {
		out += "No posts yet :c"
		return out
	}

	for i, p := range posts {
		out += "#### Post #" + strconv.Itoa(i) + "\n\n"
		out += p.String()
	}

	return out
}
