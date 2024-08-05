package twitter

import (
	"std"
	"time"
)

var (
	posts []*Post
	idCounter uint
)

type Post struct {	
	id uint

	text string
	author std.Address
	createdAt time.Time
}

// TODO: Create an exported function to add a new post
// The function should add a pointer to a newly created post to the posts slice
// Use the idCounter variable to assign an ID to a new post

// TODO: Create an exported function to remove a post by ID
// Only the author of the post should be able to remove it
// panic if the caller is not the author!
