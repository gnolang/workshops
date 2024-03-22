package memeland

import (
	"std"
	"strconv"
	"strings"
	"time"

	"gno.land/p/demo/avl"
	"gno.land/p/demo/seqid"
)

type Post struct {
	ID            string
	Data          string
	Author        std.Address
	Timestamp     time.Time
	UpvoteTracker *avl.Tree // address > struct{}{}
}

type Memeland struct {
	Posts       []*Post
	MemeCounter seqid.ID
}

// NewMemeland returns a pointer to a new Memeland object
// Initializes all the subfields
func NewMemeland() *Memeland {
	panic("implement me")
}

// PostMeme - Adds a new post at timestamp, with data
// Panics in case data is empty or timestamp is invalid
// Returns the ID of the created Post
func (m *Memeland) PostMeme(data string, timestamp int64) string {
	panic("implement me")
}

// Upvote increases the upvote count of a specific Post
// Panics if specified ID doesn't exist, or the user has already upvoted
func (m *Memeland) Upvote(id string) string {
	panic("implement me")
}

// GetPostsInRange returns a JSON object containing marshalled Posts in a specific timestamp range
// Timestamps are given as Unix seconds
// Supports pagination
// sortBy can be "UPVOTES" (most upvotes-first), or "DATE_CREATED" (newest-first)
// Panics if page < 1, pageSize < 1, or pageSize > 10
// Returns empty JSON object if there are no posts in the specified range.
func (m *Memeland) GetPostsInRange(startTimestamp, endTimestamp int64, page, pageSize int, sortBy string) string {
	panic("implement me")
}

// getPost gets a post by ID
func (m *Memeland) getPost(id string) *Post {
	panic("implement me")
}

// PostsToJSONString converts a slice of Post structs into a JSON string
func PostsToJSONString(posts []*Post) string {
	var sb strings.Builder
	sb.WriteString("[")

	for i, post := range posts {
		if i > 0 {
			sb.WriteString(",")
		}

		sb.WriteString(PostToJSONString(post))
	}
	sb.WriteString("]")

	return sb.String()
}

// PostToJSONString returns a Post formatted as a JSON string
// Note: Gno currently does not support reflection, which is why JSON marshalling is unavailable
func PostToJSONString(post *Post) string {
	var sb strings.Builder

	sb.WriteString("{")
	sb.WriteString(`"id":"` + post.ID + `",`)
	sb.WriteString(`"data":"` + escapeString(post.Data) + `",`)
	sb.WriteString(`"author":"` + escapeString(post.Author.String()) + `",`)
	sb.WriteString(`"timestamp":"` + strconv.Itoa(int(post.Timestamp.Unix())) + `",`)
	sb.WriteString(`"upvotes":` + strconv.Itoa(post.UpvoteTracker.Size()))
	sb.WriteString("}")

	return sb.String()
}

// escapeString escapes quotes in a string for JSON compatibility.
func escapeString(s string) string {
	return strings.ReplaceAll(s, `"`, `\"`)
}
