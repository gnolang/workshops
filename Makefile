ROWS=15
FILE="README.md"

build:
	# Delete existing table if it exists
	go run ./scripts format --rmtable --readme README.md

	# Generate new table
	go run ./scripts -path ./presentations -out ./scripts/data.csv
	cat ./scripts/data.csv | go run moul.io/mdtable csv > ./scripts/table.md
	go run github.com/campoy/embedmd -w README.md

	# Remove codeblocks from embedmd
	go run ./scripts format --readme README.md

	# Clean up
	rm ./scripts/data.csv ./scripts/table.md


lint:
	go run ./scripts lint --readme README.md