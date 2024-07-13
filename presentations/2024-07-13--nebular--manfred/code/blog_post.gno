package blog

import "time"

type Post struct {
	id       int
	Date     time.Time
	Name     string
	Comments []Post
}

var posts []Post

func Post(name, body string) Post {
	post := Post{len(posts), time.Now(), name, body}
	posts = append(posts, post)
	return post
}
