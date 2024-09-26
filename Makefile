build:
	go run scripts/csvgen.go
	mdtable csv metadata.csv
	# gen md.md
	# embedmd