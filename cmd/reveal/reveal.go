// Command reveal allows you to generate an HTML file, rendering a
// Markdown-based reveal.js presentation.
package main

import (
	"bytes"
	"fmt"
	"os"
	"strings"

	"gopkg.in/yaml.v3"
)

func main() {
	var es int
	for _, v := range os.Args[1:] {
		if err := convertFile(v); err != nil {
			fmt.Fprintf(os.Stderr, "%s: error converting: %v", v, err)
			es = 1
		}
	}
	os.Exit(es)
}

func convertFile(fname string) error {
	mdSrc, err := os.ReadFile(fname)
	if err != nil {
		return err
	}

	parts := bytes.SplitN(mdSrc, []byte("---\n"), 3)
	if len(parts[0]) != 0 {
		return fmt.Errorf("invalid front matter")
	}
	var config combinedConfig
	err = yaml.Unmarshal(parts[1], &config)
	if err != nil {
		return err
	}
	rd := config.renderData()
	rd.Presentation = string(parts[2])
	newFname := stripAnySuffix(fname, ".reveal.md", ".md") + ".html"
	dest, err := os.Create(newFname)
	if err != nil {
		return err
	}
	defer dest.Close()
	if err = tpl.Execute(dest, rd); err != nil {
		return err
	}

	fmt.Printf("%s converted to %s\n", fname, newFname)
	return nil
}

func stripAnySuffix(s string, suffixes ...string) string {
	for _, suff := range suffixes {
		if strings.HasSuffix(s, suff) {
			return s[:len(s)-len(suff)]
		}
	}
	return s
}
