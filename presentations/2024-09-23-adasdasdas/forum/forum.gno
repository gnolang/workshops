package forum

import (
	"gno.land/p/demo/avl"
	"gno.land/p/demo/ufmt"

	"std"
	"strconv"
	"strings"
)

var (
	idCounter  int
	threadList avl.Tree // id -> *Thread
)

type Thread struct {
	ID     int
	Title  string
	Body   string
	Author std.Address
}

func NewThread(title, body string) (threadID int) {
	idCounter++
	threadList.Set(strconv.Itoa(idCounter), &Thread{
		ID:     idCounter,
		Title:  title,
		Body:   body,
		Author: std.PrevRealm().Addr(),
	})
	return idCounter
}

func Render(param string) string {
	if param != "" {
		val, ok := threadList.Get(param)
		if !ok {
			panic("thread not found")
		}
		thread := val.(*Thread)
		return ufmt.Sprintf("# %s\n\n%s", thread.Title, thread.Body)
	}

	var bld strings.Builder

	bld.WriteString("# Forum\n")

	threadList.Iterate("", "", func(key string, value interface{}) bool {
		thread := value.(*Thread)
		bld.WriteString(ufmt.Sprintf("- %s: [%s](./forum:%s) by %s\n", key, thread.Title, key, thread.Author.String()))
		return false
	})

	return bld.String()
}
