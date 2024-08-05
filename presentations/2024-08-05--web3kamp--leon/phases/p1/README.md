# Web3 Kamp - P1 - Local Installation

Follow the [installation steps](https://docs.gno.land/getting-started/local-setup/installation)
to install the tools necessary to complete the workshop. First verify the prerequisite requirements
are installed before installing `gno`, `gnodev`, and `gnokey`.

## Syntax highlighting

This step is optional but convenient. We have a few [supported editor extensions](https://github.com/gnolang/gno/blob/master/CONTRIBUTING.md#environment)
that enable gno syntax highlighting, including VSCode, ViM, emacs, and Sublime.

## gnokey - the CLI wallet

Let's generate a key pair. A key pair is what is used to sign transactions that are broadcast
to the gno.land blockchain. In a real world context, they should not be shared.

### add

Add a new key by running `gnokey add <keyname>`. Choose whichever key name you'd like. Shorter is better
since you'll have to type it at least a few times. A passphrase is optional and in our case unnecessary, so
you can enter through this without typing anything.

Notice the mnemonic phrase that is generated. In a real world scenario, you would want to record this
and store it offline, ideally on a piece of paper or other method of offline storage for security.

### list

Run `gnokey list`. You should see that a key has been added with the specified name.

## gnodev

`gnodev` is a tool to more easily facilitate development on gno.land. It's basic features include:

- spinning up an in-memory node
- automatically deploying local packages to the chain
- reloading packages when file changes are made
- starting a web server using `gnoweb` to provide a UI

From this directory, try running `gnodev .`. If successful, the last line should be `` --- READY   ┃ I for commands and help, press `h`  ``.

## Setup complete!

You've just set up a local gno.land development environment 🎉

To see the Hello World example in action, visit [localhost:8888/r/petnica/hello](http://localhost:8888/r/petnica/hello).
