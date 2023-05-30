// from gno.land/r/demo/boards/post.gno

// A Post is a "thread" or a "reply" depending on context.
// A thread is a Post of a Board that holds other replies.
type Post struct {
	board       *Board
	id          PostID
	creator     std.Address
	title       string // optional
	body        string
	replies     avl.Tree // Post.id -> *Post
	repliesAll  avl.Tree // Post.id -> *Post (all replies, for top-level posts)
	reposts     avl.Tree // Board.id -> Post.id
	threadID    PostID   // original Post.id
	parentID    PostID   // parent Post.id (if reply or repost)
	repostBoard BoardID  // original Board.id (if repost)
	createdAt   time.Time
	updatedAt   time.Time
}
