package board

type Post struct{}

type Board struct{}

func (b *Board) Post(name, body string) Post

func (b *Board) Comment(id string, body string) {
	if id < 0 || id >= len(b.posts) {
		panic("invalid id")
	}
	caller := std.GetOrigCaller()

	post := &b.posts[id]
	comment := Post{len(post.Comment), caller, "", body}
	post.Comment = append(post.Comment, post)
}
