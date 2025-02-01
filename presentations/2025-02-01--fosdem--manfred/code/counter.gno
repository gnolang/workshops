package counter

import "strconv"

var counter int

func Incr() {
	counter += 1
}

func Render(_ string) string {
	return "my decentralized counter: " + strconv.Itoa(counter)
}
