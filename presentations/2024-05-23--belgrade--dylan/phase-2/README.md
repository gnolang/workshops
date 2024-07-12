# Phase 2

## Goal
Embed a Gno VM in a CLI application, create a Gno application, and interact with it by calling functions.

## Instructions
- The `adder.gno` application is included here along with the Go app, `main.go`
- Run `go run main.go create -file adder.gno` to create the `adder` app.
- Run `go run main.go call -app adder -func Add -args 2` to add 2 to the application's running total
- Run `go run main.go call -app adder -func Value` to obtain the `adder` app's current value via its `Value` function