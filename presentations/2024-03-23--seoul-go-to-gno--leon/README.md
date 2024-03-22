# Go to Gno Builder Challenge

Welcome to the **Go to Gno Builder Challenge**.
The Challenge is to write the Memeland package from scratch.

Check out the sections below
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
cd gno.land
make build && make install
```

3. `gnodev` - a tool to help you develop Gno apps faster
```
make install.gnodev
```

> The `install.gnodev` command can be found in the root Makefile.


## Start the Challenge

In the `api/p/memeland` folder you will be able to find the
[template package file](./memeland/api/p/memeland/memeland.gno), as well
as tests that should be passing when you are done with the Challenge.

To start tests, run `gno test . -v` in the `api/p/memeland` folder. You should 
get the following output before starting: 

```bash
❯ gno test . -v      
=== RUN   TestPostMeme
panic: implement me
--- FAIL: TestPostMeme (0.00s)
=== RUN   TestGetPostsInRangePagination
panic: implement me
--- FAIL: TestGetPostsInRangePagination (0.00s)
=== RUN   TestGetPostsInRangeByTimestamp
panic: implement me
--- FAIL: TestGetPostsInRangeByTimestamp (0.00s)
=== RUN   TestGetPostsInRangeByUpvote
panic: implement me
--- FAIL: TestGetPostsInRangeByUpvote (0.00s)
=== RUN   TestNoPosts
panic: implement me
--- FAIL: TestNoPosts (0.00s)
=== RUN   TestUpvote
panic: implement me
--- FAIL: TestUpvote (0.00s)
.: test pkg: failed: "TestPostMeme"; failed: "TestGetPostsInRangePagination"; failed: "TestGetPostsInRangeByTimestamp"; failed: "TestGetPostsInRangeByUpvote"; failed: "TestNoPosts"; failed: "TestUpvote"
FAIL
FAIL    .       0.57s
FAIL
FAIL
FAIL: 0 build errors, 1 test errors
```

After completing the challenge, all tests should be passing.

## Running a local frontend

Memeland comes with a pre-built UI, which can be found in the`ui/`
folder. Once you have implemented all the needed functions in the Memeland package,
you can fully run your version of Memeland.

### `gnodev`

`gnodev` is a tool that will deploy your Gno code to a local gno.land node, 
and expose an RPC endpoint for the UI to connect to it. Start `gnodev`, giving
it the paths to the Memeland package and realm folders:

```
gnodev ./api/p/memeland ./api/r/memeland
```

Then, in the `ui/` folder:
- Install all necessary dependencies with `yarn`,
- make a `.env` file from the `.env.example`,
- run `yarn dev` to start a vite server for your UI

## Adena wallet

To connect and interact with the Memeland app, you need to install the 
[Adena wallet](https://adena.app). After installing Adena,
create a new account with the following mnemonic:

```
source bonus chronic canvas draft south burst lottery vacant surface solve popular case indicate oppose farm nothing bullet exhibit title speed wink action roast
```

After completing this step, you will be able to interact with the Memeland app.

**Congratulations! You've completed the Go to Gno Builder Challenge!**

Please upload your code to a GitHub repository and submit your work
[here](https://forms.gle/94Qr9VcbySefpmco8).
