# Phase 4

## Goal
Allow a user to remotely install an application from another user.

## Instructions
- Open two terminal windows, one for each the `cmd/alice` and `cmd/bob` directories
- In each directory, run `go run main.go`
- Alice is running on port 4591, Bob on 4592
- Install an app on Alice's VM by navigating to `localhost:4591/installer`, pasting the code from `myname.gno` from phase 4, and submitting.
- Navigate to `localhost:4591/myname:Alice` to ensure that the app was installed.
- Now navigate to `localhost:4592/remoteinstaller` on Bob's machine.
- Type in Alice's address, `localhost:4591`, and the name of the app to install on Bob's VM, `myname`
- Navigate to `localhost:4592/myname` to confirm the installation succeeded.