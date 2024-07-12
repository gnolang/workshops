package main

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"github.com/gnolang/gno/gno.me/server"
)

func main() {
	gnoServer := server.Start("4592", "5592")

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

	<-done
}
