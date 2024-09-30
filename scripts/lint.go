package main

import (
	"fmt"
	"os"
	"slices"
	"strings"
)

const (
	presFolder = "../presentations"
	readme     = "../README.md"
)

func main() {
	dirs, err := os.ReadDir(presFolder)
	if err != nil {
		panic(err)
	}

	var dates []string
	for _, dir := range dirs {
		// Skip non-dirs
		if !dir.IsDir() {
			continue
		}

		dates = append(dates, dir.Name()[:10]) // get date out of dir name
	}

	slices.Sort(dates)
	slices.Reverse(dates)

	rawContents, err := os.ReadFile(readme)
	if err != nil {
		panic(err)
	}

	cts := string(rawContents)

	for _, date := range dates[:15] {
		if !strings.Contains(cts, date) {
			panic("could not find latest item in README table - did you run `make build`?")
		}
	}

	fmt.Println("All good!")
}
