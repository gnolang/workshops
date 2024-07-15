## 04_GnoLand - Publish Your Realm on Gno.Land

`Gno.Land` is the platform where you can upload your contract and make it available to the world, on-chain. When publishing on `Gno.Land`, there is no rollback or hot reload. Your contract will remain there permanently, so be cautious when choosing the package path to publish your realm.

### Faucet Hub

Unlike `gnodev`, you don't have any tokens to interact with the chain (yet). Let's get some for your key on the `Faucet Hub`.

1. Go to https://faucet.gno.land and select `Portal Loop`.
2. Enter the wallet address you created in the previous section (use `gnokey list` to retrieve the key address).
3. Select the faucet amount and click on `Request Drip`.

Your address should now have received some tokens!

You can verify your current balance by running:
```bash
$ gnokey query --remote https://rpc.gno.land bank/balances/<wallet_address>
```
> wallet address should be in the form `g1xxxx...`

This command should display the current amount of `ugnot` you possess in your wallet.

### Publish

Now, it's time to upload your first package. We'll upload the package inside `04_gnoland`.

1. Choose a package path name. It's recommended to use your address as the namespace for your contract:
    * Example: `gno.land/r/g1hr3dl82edy84a5f3dmchh0due7zgwm5rnns6na/myrealm`
2. Run the following command to publish the package on `gno.land`:
```bash
$ gnokey maketx addpkg "<MY_KEY_NAME>" \
    -pkgpath "<PKG_PATH_NAME>" \
    -pkgdir "<LOCAL_PKG_DIR>" \
    -gas-fee 1ugnot \
    -gas-wanted 10000000 \
    -broadcast \
    -chainid portal-loop \
    -remote https://rpc.gno.land

# * `MY_KEY_NAME`: the name of your key used in the gnokey section; use `gnokey list` to retrieve it.
# * `LOCAL_PKG_DIR`: the local directory containing the realm (package) you want to publish.
# * `PKG_PATH_NAME`: the package path name you chose in step 1.
# * You will be prompted for your key password.
```
3. Visit your realm on `gno.land` using the package path you chose in step 1.
    * Example: `https://gno.land/r/g1hr3dl82edy84a5f3dmchh0due7zgwm5rnns6na/myrealm`

### BONUS: Gno Bro

There are many ways to explore realms. Try running:
```bash
$ ssh bro.gno.cool
```

This will bring you to a terminal-based version of `gno.land`, where you can fetch the previously published realm by typing its path. Enjoy the magic!
