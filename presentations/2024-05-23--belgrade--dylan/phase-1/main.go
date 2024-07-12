package main

import (
	"context"
	"fmt"
	"io"
	"os"

	"github.com/gnolang/gno/gno.me/gno"
)

func main() {
	vm, _ := gno.NewVM()
	input, err := io.ReadAll(os.Stdin)
	if err != nil {
		panic("failed to read input")
	}

	res, err := vm.Run(context.Background(), string(input))
	if err != nil {
		fmt.Println("run error:", err.Error())
		return
	}

	fmt.Println("result:", res)

}
