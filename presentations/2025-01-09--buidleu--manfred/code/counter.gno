package counter

var Counter int

func Inc() {
	Counter += 1
}

func Render(path string) string {
	return "My Super Counter: " + Counter
}
