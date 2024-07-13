package blog

import "time"

type Post struct {
	id       int
	Date     time.Time
	Name     string
	Comments []Post
}

var postid int

var posts []Post

func Post(name, body string) Post {
	post := Post{postid, time.Now(), name, body}
	posts = append(posts, post)
	postid++
	return post
}
