package blog

type Post struct{}

var admin string = std.GetOrginCaller() // Set deployer as admin

var posts []Post

func Post(name, body string) Post {
	// Assert caller is admin
	caller := std.GetOrigCaller()
	if caller != admin {
		panic("unauthorized")
	}

	// Add post ...
}
