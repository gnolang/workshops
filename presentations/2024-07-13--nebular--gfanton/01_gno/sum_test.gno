package main

import "testing"

func TestSum(t *testing.T) {
	const expected = 3

	actual := Sum(1, 2)
	if actual != expected {
		t.Fatalf("invalid result, expecting %d got %d", expected, actual)
	}
}
