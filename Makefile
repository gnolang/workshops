ROWS=15

build:
	go run scripts/csvgen.go -path ./presentations -out scripts/data.csv -rows $(ROWS)
	cat scripts/data.csv | go run moul.io/mdtable csv > scripts/table.md
	go run github.com/leohhhn/embedmd -w README.md

	# Clean up
	rm scripts/data.csv scripts/table.md