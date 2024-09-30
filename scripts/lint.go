package main

import (
	"context"
	"encoding/csv"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"

	"github.com/gnolang/gno/tm2/pkg/commands"
	"gopkg.in/yaml.v3"
)

type cfg struct {
	presentationsPath string
	outputPath        string
	rows              int
}

type Metadata struct {
	Date      string   `yaml:"date"`
	Title     string   `yaml:"title"`
	Speakers  []string `yaml:"speakers"`
	Slides    string   `yaml:"slides"`
	Recording string   `yaml:"recording"`
}

var (
	csvHeader = []string{"Date", "Title", "Speakers", "Presentation", "Recording"}
)

func main() {
	cfg := &cfg{}

	cmd := commands.NewCommand(
		commands.Metadata{
			Name:       "",
			ShortUsage: "csvgen [flags]",
		},
		cfg,
		func(_ context.Context, args []string) error {
			return execGen(cfg)
		})

	cmd.Execute(context.Background(), os.Args[1:])
}

func (c *cfg) RegisterFlags(fs *flag.FlagSet) {
	fs.StringVar(
		&c.presentationsPath,
		"path",
		"./",
		"path to dir to walk for presentations files",
	)
	fs.StringVar(
		&c.outputPath,
		"out",
		"./data.csv",
		"output csv path, including .csv",
	)
	fs.IntVar(
		&c.rows,
		"rows",
		15,
		"number of rows to generate",
	)
}

func execGen(cfg *cfg) error {
	searchDir := cfg.presentationsPath
	outputCSV := cfg.outputPath // todo check for err

	// Create the CSV file
	csvFile, err := os.Create(outputCSV)
	if err != nil {
		fmt.Printf("failed to create CSV file: %v", err)
		return err
	}

	defer csvFile.Close()

	writer := csv.NewWriter(csvFile)
	defer writer.Flush()

	if err = writer.Write(csvHeader); err != nil {
		fmt.Printf("failed to write to the CSV file: %v", err)
		return err
	}

	dirs, err := os.ReadDir(searchDir)
	if err != nil {
		return err
	}

	var rows []Metadata
	for _, dir := range dirs {
		// Skip non-dirs
		if !dir.IsDir() {
			continue
		}

		metadataFile := filepath.Join(searchDir, dir.Name(), "metadata.yml")
		abs, _ := filepath.Abs(metadataFile)

		// Try to find metadata.yml inside the dir
		data, err := os.ReadFile(abs)
		if err != nil {
			//fmt.Printf("Error reading metadata.yml file: %v", err)
			continue
		}

		var metadata Metadata
		if err = yaml.Unmarshal(data, &metadata); err != nil {
			//fmt.Printf("error parsing metadata.yml: %v", err)
			continue
		}

		// fix local links
		if !strings.Contains(metadata.Slides, "http") {
			metadata.Slides = filepath.Join(searchDir, dir.Name(), metadata.Slides)
		}

		// Check for empty fields
		if err = metadata.Check(abs); err != nil {
			return err
		}

		rows = append(rows, metadata)
	}

	// Sort by date
	sort.Slice(rows, func(i, j int) bool {
		return rows[i].Date > rows[j].Date
	})

	// Write sorted rows to the CSV file
	// Generate only the last N rows of data
	for _, r := range rows[:cfg.rows] {
		err = writer.Write(r.Format())
		if err != nil {
			return err
		}
	}

	return nil
}

func (m Metadata) Format() []string {
	if m.Slides == "" {
		m.Slides = "---"
	} else {
		m.Slides = fmt.Sprintf("[Slides](%s)", m.Slides)
	}

	if m.Recording == "" {
		m.Recording = "---"
	} else {
		m.Recording = fmt.Sprintf("[Video](%s)", m.Recording)
	}

	return []string{
		m.Date,
		m.Title,
		m.parseSpeakers(),
		m.Slides,
		m.Recording,
	}
}

func (m Metadata) parseSpeakers() string {
	var speakers []string
	for _, speaker := range m.Speakers {
		speakers = append(speakers, "@"+speaker)
	}

	return strings.Join(speakers, ", ")
}

func (m Metadata) Check(path string) error {
	if strings.TrimSpace(m.Title) == "" {
		return fmt.Errorf("%s: missing title", path)
	}

	if len(m.Speakers) == 0 {
		return fmt.Errorf("%s: missing speakers", path)
	}

	if strings.TrimSpace(m.Date) == "" {
		return fmt.Errorf("%s: missing date", path)
	}

	return nil
}
