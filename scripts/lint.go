package main

import (
	"context"
	"fmt"
	"os"
	"slices"
	"strings"

	"github.com/gnolang/gno/tm2/pkg/commands"
)

func newLintCmd(cfg *cfg) *commands.Command {
	cmd := commands.NewCommand(
		commands.Metadata{
			Name:      "lint",
			ShortHelp: "lint the README table",
		},
		commands.NewEmptyConfig(),
		func(_ context.Context, args []string) error {
			return execLint(cfg)
		},
	)
	return cmd
}

func execLint(cfg *cfg) error {
	dirs, err := os.ReadDir(cfg.presentationsPath)
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

	rawContents, err := os.ReadFile(cfg.readmePath)
	if err != nil {
		panic(err)
	}

	cts := string(rawContents)

	for _, date := range dates {
		if !strings.Contains(cts, date) {
			panic("could not find some items in README table - did you run `make build`?")
		}
	}

	fmt.Println("All good!")

	return nil
}
