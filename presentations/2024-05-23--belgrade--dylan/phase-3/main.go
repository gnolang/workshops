package main

import (
	"fmt"

	"github.com/gnolang/gno/gno.me/apps"
	"github.com/gnolang/gno/gno.me/gno"
	"github.com/gnolang/gno/gno.me/http"
)

const port = "4591"

func main() {
	vm, firstStartup := gno.NewVM()
	if firstStartup {
		if err := apps.CreatePort(vm); err != nil { // installer dependency
			fmt.Println("could not create port app: " + err.Error())
			return
		}

		if err := apps.CreateInstaller(vm); err != nil {
			fmt.Println("could not create installer app: " + err.Error())
			return
		}
	}

	server := http.NewServer(vm, port)
	fmt.Println("Server started on port " + port)
	fmt.Println("Visit http://localhost:" + port + "/installer")
	if err := server.ListenAndServe(); err != nil {
		panic("could not start server: " + err.Error())
	}
}
