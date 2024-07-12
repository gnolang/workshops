# Phase 1

## Goal
Embed a Gno VM inside a Go application.

## Instructions
- The included `hello.gno` file is a Gno application with a `main` function.
- The `main.go` file has code that embeds a Gno VM and runs Gno code provided from `stdin`.
- Run the program to interpret `hello.gno` by issuing the command `cat hello.gno | go run main.go`.