package main

import (
	"context"
	"flag"
	"fmt"
	"os"
	"strings"

	"github.com/gnolang/gno/gno.me/gno"
)

var (
	// call flags
	callSet   = flag.NewFlagSet("call", flag.ExitOnError)
	callApp   = callSet.String("app", "", "app to call")
	callFunc  = callSet.String("func", "", "function to call")
	callIsPkg = callSet.Bool("pkg", false, "is package")

	// create flags
	createSet   = flag.NewFlagSet("create", flag.ExitOnError)
	createIsPkg = createSet.Bool("pkg", false, "is package")
	createFile  = createSet.String("file", "", "name of the .gno file")
)

type sliceFlag []string

func (s *sliceFlag) Set(value string) error {
	*s = append(*s, value)
	return nil
}

func (s *sliceFlag) String() string {
	return strings.Join(*s, ",")
}

func main() {
	vm, _ := gno.NewVM()

	var callArgs sliceFlag
	callSet.Var(&callArgs, "args", "arguments to call function with")

	if len(os.Args) < 2 {
		flag.Usage()
		os.Exit(1)
	}

	var (
		result string
		err    error
	)

	switch os.Args[1] {
	case "call":
		callSet.Parse(os.Args[2:])
		result, _, err = vm.Call(context.Background(), *callApp, *callIsPkg, *callFunc, callArgs...)
	case "create":
		createSet.Parse(os.Args[2:])
		var code []byte
		code, err = os.ReadFile(*createFile)
		if err != nil {
			panic("failed to read file")
		}

		_, err = vm.Create(context.Background(), string(code), *createIsPkg, false)
	}

	if err != nil {
		fmt.Println("error:", err.Error())
		return
	}

	if result == "" {
		result = "OK"
	}

	fmt.Println("result:", result)
}
