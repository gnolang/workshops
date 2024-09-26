ROWS=15
TABLE_START_LINE="[embedmd]:# (table.md)"

build:
	go run scripts/csvgen.go -path ./presentations -out data.csv -rows $(ROWS)
	cat data.csv | mdtable csv > table.md
	embedmd -w README.md

	# Find the line where the table embedmd starts
	TABLE_START=$$(grep -n "$(TABLE_START_LINE)" README.md | cut -d: -f1)

	# Delete the line immediately after the TABLE_START line
	sed -i '' "$$((TABLE_START+1))d" README.md

	# Skip 2 + ROWS lines and delete that line
	sed -i '' "$$((TABLE_START+2+$(ROWS)))d" README.md

	# Clean up
	rm data.csv table.md
