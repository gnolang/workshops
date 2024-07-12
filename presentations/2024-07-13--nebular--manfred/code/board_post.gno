package board

type Post struct {
	id       int
	Author   std.Address
	Name     string
	Comments []Post
}

type Board []Post

func (b *Board) Post(name, body string) Post {
	caller := std.GetOrigCaller()
	post := Post{len(posts), caller, name, body}
	posts = append(posts, post)
	postid++
	return post
}
