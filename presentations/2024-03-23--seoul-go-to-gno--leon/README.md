# Go to Gno Builder Challenge

Welcome to the Go to Gno Builder Challenge. Check out the sections below
to get started.

## Installation

All needed tools can be found in the [Gno monorepo](https://github.com/gnolang/gno).

First, clone the monorepo:

```bash
git clone git@github.com:gnolang/gno.git
```

Next, install all the necessary binaries:

1. `gno` - binary for running & testing the Gno language, found in `gnovm/`. 
Run

```
cd gnovm
make build && make install
```

2. `gnoland` - binary containing the node which opens up an RPC API, found in 
`gno.land/`

```
cd ../gno.land
make build && make install
```

3. `gnodev` - tooling to help you develop Gno apps faster
```
cd ..
make install.gnodev
```

> `install.gnodev` can be found in the root Makefile.