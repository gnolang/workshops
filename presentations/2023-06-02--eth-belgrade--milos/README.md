# Gnolang workshop: Alice in Gno.land

The recording of this workshop is available [here](#).

## Requirements for the workshop

To participate in the workshop, please ensure that you have the following requirements:

* Internet connection
* Git
* Go 1.19+
* Make (for using Makefiles)
* Text editor

## Nice to have

If you are using Visual Studio Code, we recommend installing the [Gno language extension](https://marketplace.visualstudio.com/items?itemName=harry-hov.gno) from the marketplace. This extension provides helpful features such as highlighting formatting errors and syntax highlighting for `.gno` files.

## Workshop Commands
### Initial Setup

To clone the gno GitHub repository, run the following command:

```bash
git clone https://github.com/gnolang/gno.git
```

### Building/Installing the gno tools

From the root of the cloned repository, navigate to gno.land and run the following commands:

```bash
cd gno.land
make build && make install
```

Next, navigate to the `gnovm` directory and execute the following commands:

```bash
cd gnovm
make build && make install
```

### Generating Keys

To generate the bip39 mnemonic for the private key, use the following command:

```bash
gnokey generate
```

Make sure to copy this mnemonic as it will be needed for the next step. To create a key called Milos (you can change the key name if desired), use the following command:

```bash
gnokey add --recover Milos
```

Follow the on-screen instructions to generate the key.

### Viewing Available Keys

To view the added keys, use the following command:

```bash
gnokey list
```

This will display the associated Gno account addresses for each key. Note down the address as it will be used later.

### Adding Funds to an Account

To add funds to an account, you have two options: [running a separate faucet service](https://github.com/gnolang/gno/tree/master/gno.land/cmd/gnofaucet) or premining balances. For this tutorial, we will premine the balance by appending a line to the `genesis_balances.txt` file located in the root repository (`gno/gno.land/genesis/genesis_balances.txt`).

Run the following command, replacing the address with your own:

```bash
g1wxkyp3v9w4llp5tyyr64a8ly532dzvd3z57wy6=10000000000ugnot # @Milos
```

Of course, change the address to match the one you are using for this tutorial.

### Starting the Gno Blockhain Node

To start the Gno blockchain node, ensure that you have completed the steps in the [setup tutorial](#buildinginstalling-the-gno-tools), and then run the following command:

```bash
gnoland
```

This will start a local blockchain node with the chain ID `dev`, running at `localhost:26657`.

### Starting the Gno Website

To start the Gno website, execute the following command:

```bash
gnoweb
```

You can view the realm state by accessing the Realm page once it has been deployed at:

`http://127.0.0.1:8888/r/demo/madhat`

### Deploying the Package

To deploy the `party` gno package using the `Milos` key, run the following command:
```bash
gnokey maketx addpkg \
--pkgpath "gno.land/p/demo/party" \
--pkgdir "./p/party/" \
--gas-fee 1000000ugnot \
--gas-wanted 800000 \
--broadcast \
--chainid dev \
--remote localhost:26657 \
Milos
```

### Deploying the Realm

To deploy the `madhat` gno realm (smart contract) using the `Milos` key, run the following command:
```bash
gnokey maketx addpkg \
--pkgpath "gno.land/r/demo/madhat" \
--pkgdir "./r/madhat/" \
--gas-fee 1000000ugnot \
--gas-wanted 800000 \
--broadcast \
--chainid dev \
--remote localhost:26657 \
Milos
```

### Creating a Party

To create a new Mad hat party as the Smart Contract owne using the `Milos` key, run the following command:
```bash
gnokey maketx call \
--pkgpath "gno.land/r/demo/madhat" \
--func "NewTeaParty" \
--args "First party" \
--args "A lovely little party" \
--args 1685570701 \
--gas-fee 1000000ugnot \
--gas-wanted 800000 \
--broadcast  \
--remote localhost:26657 \
Milos
```

### RSVPing to a Party

To RSVP to an existing party using the `Milos` key, run the following command:

```bash
gnokey maketx call \
--pkgpath "gno.land/r/demo/madhat" \
--func "RSVP" \
--args 0 \
--gas-fee 1000000ugnot \
--gas-wanted 800000 \
--broadcast  \
--remote localhost:26657 \
Milos
```
