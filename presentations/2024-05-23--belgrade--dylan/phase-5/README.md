# Phase 5

## Goal
Install an app that other users can install. Sync the app data to all users' machines.

## Instructions
- Open two terminal windows, one for each the `cmd/alice` and `cmd/bob` directories
- In each directory, run `go run main.go`
- Alice is running on port 4591, Bob on 4592
- Open the provided postman collection and execute the requests in order OR run the provided `run_all.sh` file
- Running the postman collection, one request at a time and navigating to `localhost:<port>/postit` on each of the users' machines, allows you to see how each request is updating, and then syncing, the state.