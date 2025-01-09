package counter

import "std"

var (
	Counter    int
	LastCaller std.Address
)

func Inc() int {
	return addToCounter(1)
}

func Add(amount int) int {
	return addToCounter(amount)
}

func addToCounter(amount int) int {
	Counter += amount
	LastCaller = std.GetOrigCaller()
	return Counter
}
