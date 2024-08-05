package twitter

import (
	"std"
	"time"
)

type Post struct {
	id uint

	text string
	author std.Address
	createdAt time.Time
	upvotes uint
	downvotes uint

	tipTotal int64
}

var (
	posts []*Post
	idCounter uint
)

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
		tipTotal: 0,
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

func TipPost(id uint) {
	tipAmt := std.GetOrigSend().AmountOf("ugnot")
	if tipAmt <= 0 {
		panic("cannot tip 0 or less!")
	}
	
	_, p := getPost(id)
	if p == nil {
		panic("could not find post with specified id")
	}

	banker := std.GetBanker(std.BankerTypeOrigSend)

	coinTip := std.NewCoin("ugnot", tipAmt)
	banker.SendCoins(std.CurrentRealm().Addr(), p.author, std.NewCoins(coinTip))

	p.tipTotal += tipAmt
}

func getPost(id uint) (int, *Post) {
	for i, p := range posts {
		if p.id == id {
			return i, p
		}
	}

	return -1, nil
}


