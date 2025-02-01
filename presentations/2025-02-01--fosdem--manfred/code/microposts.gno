package microposts

import (
	"errors"
	"std"
	"time"

	"gno.land/p/demo/ufmt"
	"gno.land/p/moul/md"
)

var posts []*Post

type Post struct {
	text      string
	author    std.Address
	createdAt time.Time
}

// CreatePost is automatically exposed as an endpoint
// It can be accessed by anyone who has a user ID (key pair)
func CreatePost(text string) error {
	if text == "" {
		return errors.New("empty post text")
	}

	posts = append(posts, &Post{
		text:      text,
		author:    std.PrevRealm().Addr(), // provided by env
		createdAt: time.Now(),
	})

	return nil
}

func Render(_ string) string {
	out := md.H1("Posts")

	if len(posts) == 0 {
		out += "No posts."
		return out
	}

	for i := len(posts) - 1; i >= 0; i-- {
		out += md.H3(ufmt.Sprintf("Post #%d\n\n", i))
		out += posts[i].String()
		out += "---\n\n"
	}

	return out
}

func (p Post) String() string {
	out := p.text
	out += "\n\n"
	out += ufmt.Sprintf("_%s, by %s_", p.createdAt.Format("02 Jan 2006, 15:04"), p.author)
	out += "\n\n"

	return out
}

