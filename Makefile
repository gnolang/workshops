ROWS=15
FILE="README.md"

build:
	./scripts/del-existing-rows.sh $(ROWS) $(FILE)

	go run scripts/csvgen.go -path ./presentations -out scripts/data.csv -rows $(ROWS)
	cat scripts/data.csv | go run moul.io/mdtable csv > scripts/table.md
	go run github.com/campoy/embedmd -w README.md
	# Clean up
	rm scripts/data.csv scripts/table.md

	./scripts/del-codeblock.sh $(FILE)

