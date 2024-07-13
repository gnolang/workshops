package guest

import "std"

var messages avl.Tree // std.Address -> string (message)

func AddMessage(message string) {
	caller := std.GetOrigCaller()
	if _, ok := messages.Get(caller); ok {
		panic("this user already post a message")
	}
	messages.Set(caller, message) // add message to our messages list
}

func Render(path string) string {
	var view string
	for _, message := range messages {
		view = view + "\n" + message // add message to the render
	}
	return view
}
