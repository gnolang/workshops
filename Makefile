build:
	go run scripts/csvgen.go -path ./presentations -out data.csv -rows 15
	cat data.csv | mdtable csv > table.md
	embedmd -w README.md
	rm data.csv table.md
