## Bring Your Realm to Life with Gnokey

`gnokey` is a command-line tool for interacting with a blockchain node. It allows you to make blockchain transactions, publish new packages, and perform various operations with a remote or local blockchain node.

### Create an Account

To create an account, simply type:

```
$ gnokey add mykeyname
```
__Replace `mykeyname` with the desired name for your key.__

You will be prompted to enter a password to secure your key. It is strongly recommended to use a password, as using the key without one is not advisable outside of this workshop.

You can then verify that your key has been correctly added to the keybase by typing:

```
$ gnokey list
```

This should correctly display your newly created key.

### Start gnodev

As in the previous exercise, start `gnodev` target this directory by typing

```
$ gnodev ./03_gnokey
```

To load the `counter` package on `gno.land/r/nebular24/gnokey`

`gnodev` should automatically load the key you just created. You can verify this
by pressing `A` within `gnodev` to display all known accounts and their
balances. 

In `gnodev`, your account should have been premined with enough tokens
to do whatever you want.

### Interact with the contract

You can then interact with the realm using the `maketx call` command from gnokey

```
$ gnokey maketx call \
	-pkgpath "gno.land/r/nebular24/gnokey" \
	-func "Inc" \
	-gas-fee 1ugnot \
	-gas-wanted 2000000 \
	-broadcast \
	-chainid "dev" \
	-remote "127.0.0.1:26657" mykeyname
```
__Replace `mykeyname` with your key.__



