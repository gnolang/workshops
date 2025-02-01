package microposts

import (
	"std" // gno specific
	"time"
)

var posts []*Post

type Post struct {
	text      string
	author    std.Address
	createdAt time.Time
}

func CreatePost(text string) {
	posts = append(posts, &Post{
		text:      text,
		author:    std.PrevRealm().Addr(), // provided by env
		createdAt: time.Now(),
	})
}
