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
	upvotes uint
	downvotes uint
	// TODO: add a total tips counter to measure how many tips the post has received
}

func AddPost(text string) uint {
	if text == "" {
		panic("post text cannot be empty")
	}

	p := &Post{
		text: text,
		id: idCounter,
		author: std.PrevRealm().Addr(),
		createdAt: time.Now(),
		upvotes: 0,
		downvotes: 0,
	}

	posts = append(posts, p)
	idCounter++

	return p.id
}

func RemovePost(id uint) {
	caller := std.PrevRealm().Addr()

	idx, p := getPost(id)
	if p == nil {
		panic("could not find post with specified id")
	}

	if p.author != caller {
		panic("you are not the author of this post!")
	}

	posts = append(posts[:idx], posts[idx+1:]...)
}

func Upvote(id uint) {
	_, p := getPost(id)
	if p == nil {
		panic("could not find post with specified id")
	}

	p.upvotes++
}

func Downvote(id uint) {
	_, p := getPost(id)
	if p == nil {
		panic("could not find post with specified id")
	}

	p.downvotes++
}

// TODO: Add an exported TipPost function
// The function will allow a user to tip a post with ugnot

func getPost(id uint) (int, *Post) {
	for i, p := range posts {
		if p.id == id {
			return i, p
		}
	}

	return -1, nil
}
