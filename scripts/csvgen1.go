package main

import (
	"context"
	"encoding/csv"
	"flag"
	"fmt"
	"github.com/gnolang/gno/tm2/pkg/commands"
	"os"
	"path/filepath"
	"sort"
)

type cfg struct {
	presentationsPath string
	outputPath        string
}

type Metadata struct {
	Title     string   `yaml:"title"`
	Speakers  []string `yaml:"speakers"`
	Date      string   `yaml:"date"`
	Slides    string   `yaml:"slides"`
	Recording string   `yaml:"recording"`
}

type Record struct {
	Date      string
	Title     string
	Speakers  string
	Slides    string
	Recording string
}

var (
	csvHeader = []string{"Date", "Title", "Speakers", "Slides", "Recording"}
)

func main() {
	cfg := &cfg{}

	cmd := commands.NewCommand(
		commands.Metadata{
			Name:       "",
			ShortUsage: "gencsg [flags]",
			ShortHelp:  ``,
		},
		cfg,
		func(ctx context.Context, args []string) error {
			return execGen(cfg, ctx)
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
		"output csv path",
	)
}



func execGen(cfg *cfg, ctx context.Context) error {
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

	var records []Record

	dirs, err := os.ReadDir(searchDir)
	if err != nil {
		return err
	}

	for _, dir := range dirs {
		// Skip non-dirs
		if !dir.IsDir() {
			continue
		}

		metadataFile := filepath.Join(path, "metadata.yml")

		// Try to find metadata.yml inside the dir
		if _, err = os.Stat(metadataFile); err == nil {
			metadataFile := filepath.Join(path, "metadata.yml"
			data, err := os.ReadFile(metadataFile)

		}

	}

	err = filepath.Walk(searchDir, func(path string, info os.FileInfo, err error) error {

		if info.IsDir() {
			metadataFile := filepath.Join(path, "metadata.yml")
			if _, err := os.Stat(metadataFile); err == nil {

				data, err := os.ReadFile(metadataFile)
				if err != nil {
					fmt.Println("Error reading file:", err)
					return err
				}

				// Parse the YAML file
				var metadata Metadata
				err = yaml.Unmarshal(data, &metadata)
				if err != nil {
					fmt.Println("Error parsing YAML:", err)
					return err
				}

				// Prepare speakers, prepend "@" to each
				speakers := []string{}
				for _, speaker := range metadata.Speakers {
					speakers = append(speakers, "@"+speaker)
				}
				speakerStr := strings.Join(speakers, ", ")

				// Handle slides and recording with markdown links or defaults
				slides := metadata.Slides
				if slides == "" {
					slides = "---"
				} else {
					slides = fmt.Sprintf("[Slides](%s)", slides)
				}

				recording := metadata.Recording
				if recording == "" {
					recording = "---"
				} else {
					recording = fmt.Sprintf("[Recording](%s)", recording)
				}

				// Append the record to the slice
				records = append(records, Record{
					Date:      metadata.Date,
					Title:     metadata.Title,
					Speakers:  speakerStr,
					Slides:    slides,
					Recording: recording,
				})
			}
		}
		return nil
	})

	if err != nil {
		fmt.Println("Error traversing directories:", err)
		return
	}

	// Sort records by date in descending order
	sort.Slice(records, func(i, j int) bool {
		return records[i].Date > records[j].Date // Sort by date descending
	})

	// Write sorted rows to the CSV file
	for _, record := range records {
		row := []string{
			record.Date,
			record.Title,
			record.Speakers,
			record.Slides,
			record.Recording,
		}
		writer.Write(row)
	}
}
