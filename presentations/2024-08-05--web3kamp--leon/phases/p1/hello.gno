package hello

var msg string

func init() {
	msg = "Hello World!"
}

func UpdateMsg(newMsg string) {
	msg = newMsg
}

func Render(_ string) string {
	return msg
}