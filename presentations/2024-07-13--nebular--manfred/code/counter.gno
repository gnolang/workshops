package counter

var count int

func Inc() {
	count = count + 1
}

func Render() {
	return "## My Super Counter: " + count
}
