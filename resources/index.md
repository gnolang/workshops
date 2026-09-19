# Workshop Resources

This document is a living resource, designed to be completed, challenged, and improved over time.
It aggregates various recipes, examples, and links to help you compose presentations, workshops, or learn more about Gno.
Feel free to reuse the content here and contribute back by adding snippets, refining explanations, or linking to valuable resources.
Contributions can include code snippets for direct copy-pasting or useful links, such as source code for a "good first dApp" to illustrate a feature.

## Snippets and Examples

### What is Gno?

TODO: general answer

TODO: answer for web2 devs

TODO: answer for web3 devs

### Why Gno?

TODO

### How to get started?

TODO

### How to contribute?

TODO

### Packages Overview
Reusable modules in Gno, inspired by Go’s design, include a standard library. 

```go
package ufmt

import "strconv"

func Sprintf(format string, args ...interface{}) string {
    end := len(format)
    argNum := 0
    argLen := len(args)
    buf := ""

    for i := 0; i < end; i++ {
        c := format[i]
        if c != '%' {
            buf += string(c)
            continue
        }
        if argNum < argLen {
            buf += strconv.Itoa(args[argNum].(int)) // Simplified for demonstration
            argNum++
        }
    }
    return buf
}
```

### Realms Overview
End-user "smart contracts" in Gno, featuring persistent state.

```go
package counter

import "strconv"

var counter int

func Increment() int {
    counter++
    return counter
}

func Render() string {
    return strconv.Itoa(counter)
}
```

## Useful Links

- [Gno Documentation](https://docs.gno.land): Official documentation for Gno.
- [Gno GitHub Repository](https://github.com/gnolang): Explore the source code and contribute.
<!--- [Example dApps](https://github.com/gnolang/examples): A collection of dApps showcasing various features.-->
