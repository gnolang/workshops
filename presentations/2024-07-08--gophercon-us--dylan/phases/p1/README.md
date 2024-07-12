# Gnoverflow: Phase 1 (Setup and Introduction)

## Local Installation

Follow the [installation steps](https://docs.gno.land/getting-started/local-setup/installation)
to install the tools necessary to complete the workshop. First verify the prerequisite requirements
are installed before installing `gno`, `gnodev`, and `gnokey`.

## Syntax highlighting

This step is optional but convenient. We have a few [supported editor extensions](https://github.com/gnolang/gno/blob/master/CONTRIBUTING.md#environment)
that enable gno syntax highlighting, including VSCode, ViM, emacs, and Sublime.

## gno

From this directory, run `gno run hello_world.gno` to verify it is working as expected.
The expected output is `Hello, World!`.

## gnokey

Now let's generate a key pair. A key pair is what is used to sign transactions that are broadcast
to the gno.land blockchain. In a real world context, they should not be shared.

### add

Add a new key by running `gnokey add <keyname>`. Choose whichever key name you'd like. Shorter is better
since you'll have to type it at least a few times. A passphrase is optional and in our case unnecessary, so 
you can enter through this without typing anything.

Notice the mnemonic phrase that is generated. In a real world scenario, you would want to record this
and store it offline, ideally on a piece of paper or other method of offline storage for security.

### list

Run `gnokey list`. You should see that a key has been added with the specified name.

### add the default key used by `gnodev`

This workshop will at one point require transactions from multiple accounts.
You've already created one key, but `gnodev` also comes with a default key, so
let's add it to our local keybase so we can use it to sign transactions. Its
name is `test1`.

If you have `printf` installed, run `printf "\n\n%s\n" 'source bonus chronic canvas draft south burst lottery vacant surface solve popular case indicate oppose farm nothing bullet exhibit title speed wink action roast' | gnokey add --recover -insecure-password-stdin test1`

If you do not, run `gnokey add --recover test1` and enter the mnemonic `source bonus chronic canvas draft south burst lottery vacant surface solve popular case indicate oppose farm nothing bullet exhibit title speed wink action roast` when prompted. Do not use a passphrase.

## gnodev

`gnodev` is a tool to more easily facilitate development on gno.land. It's basic features include:
- spinning up an in-memory node
- automatically loading local packages to the chain
- reloading packages when file changes are made
- starting a web server using `gnoweb` to provide a UI

From this directory, try running `gnodev *`. If successful, the last line should be ``--- READY   ┃ I for commands and help, press `h` ``.

Notice there is file in a subdirectory, [gno.mod](r/gc24/setup/gno.mod). The module name is `gno.land/r/gc24/setup`.

`gnodev` is running on `localhost:8888`, so navigate to this domain appended with the latter part of the module name,
http://localhost:8888/r/gc24/setup. You should see the current time. Inspect the source at [time.gno](r/gc24/setup/time.gno)
to see how this is achieved.

Note that `gnodev` 

## Setup complete!

You've just set up a local gno.land development environment 🎉