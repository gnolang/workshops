package guessbook

import (
	"std"
	"strconv"
	"strings"
	"time"

	"gno.land/p/demo/avl"
)

type Message struct {
	Content string
	Author  string
	Date    time.Time
}

var (
	messages []Message
	users    avl.Tree // std.Address -> true
)

func AddMessage(message string) {
	std.AssertOriginCall()

	caller := std.GetOrigCaller().String()

	if _, ok := users.Get(caller); ok {
		panic("caller have alreay register a message")
	}

	users.Set(caller, true)
	messages = append(messages, Message{
		Author:  caller,
		Content: message,
		Date:    time.Now(),
	})
}

func renderMessages(msgs []Message) string {
	var str strings.Builder

	for i, msg := range msgs {
		if i > 0 {
			str.WriteString("---")
		}

		str.WriteString(renderMessage(msg))
		str.WriteRune('\n')
	}

	return str.String()
}

func renderMessage(msg Message) string {
	var str strings.Builder

	str.WriteRune('\n')
	str.WriteString("#### Writen By " + msg.Author +
		" on " + msg.Date.Format("02 Jan 2006"))
	str.WriteRune('\n')
	str.WriteString(msg.Content)
	str.WriteRune('\n')

	return str.String()
}

func Render(path string) string {
	const messagePerPage = 5

	if len(messages) == 0 {
		return "no messages yet :("
	}

	page := 0
	if path != "" {
		var err error
		page, err = strconv.Atoi(path)
		if err != nil {
			panic("unable get page number from path")
		}

		if page < 1 || (page*messagePerPage) > len(messages) {
			panic("invalid page number")
		}

		page--
	}

	startpage := page * messagePerPage
	endPage := min(startpage+messagePerPage, len(messages))
	mshow := messages[startpage:endPage]

	var view strings.Builder
	view.WriteString(renderMessages(mshow))
	view.WriteRune('\n')
	view.WriteString("---")
	view.WriteRune('\n')

	return view.String()
}

func min(a, b int) int {
	if a < b {
		return a
	}

	return b
}
