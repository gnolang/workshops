package board

type Post struct {
	id       int
	Author   std.Address
	Name     string
	Comments []Post
}

type Board struct {
	posts []Post
}

func (b *Board) Post(name, body string) Post {
	caller := std.GetOrigCaller()
	post := Post{len(b.posts), caller, name, body}
	b.posts = append(b.posts, post)
	return post
}
