package blog

type Post struct{}

var (
	adminAuthor string = std.GetOrginCaller() // Set deployer as admin
	postid      int
	posts       []Post
)

func Post(name, body string) Post {
	// Assert caller is admin
	caller := std.GetOrigCaller()
	if caller != adminAuthor {
		panic("unauthorized")
	}

	// Add post ...
}
