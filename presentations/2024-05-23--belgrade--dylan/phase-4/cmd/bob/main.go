package main

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"github.com/gnolang/gno/gno.me/server"
)

const port = "4592"

func main() {
	gnoServer := server.Start(port, "")

	// Create a channel to receive signals.
	sigs := make(chan os.Signal, 1)
	done := make(chan struct{})

	// Register a signal handler.
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)

	// Start a goroutine to handle signals.
	go func() {
		<-sigs
		fmt.Println("Shutting down server...")
		gnoServer.Stop()
		close(done)
	}()

	fmt.Println("Server started on port " + port)
	fmt.Println("Visit http://localhost:" + port + "/remote-installer")

	<-done
}
