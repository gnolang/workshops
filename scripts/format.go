package main

import (
	"context"
	"fmt"
	"os"
	"strings"

	"github.com/gnolang/gno/tm2/pkg/commands"
)

func newFormatCmd(cfg *cfg) *commands.Command {
	cmd := commands.NewCommand(
		commands.Metadata{
			Name:      "format",
			ShortHelp: "remove codeblocks from the README table",
		},
		commands.NewEmptyConfig(),
		func(_ context.Context, args []string) error {
			return execFormat(cfg)
		},
	)
	return cmd
}

// execFormat removes an existing table if rmTable is set, and removes the codeblock after table generation happened
func execFormat(cfg *cfg) error {
	read, err := os.ReadFile(cfg.readmePath)
	if err != nil {
		panic(err)
	}

	cts := string(read)
	newContents := ""

	// Called to remove the old table
	if cfg.rmTable {
		lines := strings.Split(cts, "\n")
		newLines := make([]string, 0, len(lines))
		for _, line := range lines {
			if strings.Index(line, "|") != 0 {
				newLines = append(newLines, line)
			}
		}

		newContents = strings.Join(newLines, "\n")

	} else {
		// called to remove the codeblock
		newContents = strings.Replace(cts, "```md", "", 1)
		newContents = strings.Replace(newContents, "```", "", 1)
	}

	if cts == newContents {
		fmt.Println("Nothing to format.")
		return nil
	}

	err = os.WriteFile(cfg.readmePath, []byte(newContents), 0)
	if err != nil {
		panic(err)
	}

	fmt.Println("Formatted README.md")
	return nil
}
