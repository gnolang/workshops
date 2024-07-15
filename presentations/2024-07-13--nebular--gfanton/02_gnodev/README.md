## 02_Gnodev - Debuging and Rendering

`gnodev` is a Gno development tool to works on the Gno package. It embeds a fully functional `gnoland` node (blockchain), along with `gnoweb`, a web server used to explore and visualize the `gnoland` realm.

By watching your development directory, `gnodev` detects changes in your Gno code and reflects them in the state of the node immediately. `gnodev` also runs a local instance of `gnoweb`, allowing you to see the rendering of your Gno code instantly.

### Start gnodev

To start `gnodev` on a given package, simply use the command `gnodev <pkg_path>`.

To start gnodev with the package located in this folder, use:
```bash
$ gnodev ./02_gnodev
```

> You can exit `gnodev` at any time using `Ctrl+C`.

### Gnoweb

`gnodev` will automatically serve `gnoweb` (by default on `:8888`).

> In this demo, if you are using gitpod, a browser tab will open on `gnoweb` when running `gnodev`

- On a local machine you should be able to accesse `gnoweb` in your browser with http://localhost:8888.
- If you are using gitpod, you can retreive `gnoweb` url by typing `gp url 8888` in your terminal session

### Access Your Realm

You can then access your realm by reaching `http://<gnoweb_url>/<module_path>` url.

So for the realm (package) located in the same directory as this `README`, it will be:
-  `http://localhost:8888/r/nebular24/gnodev` in case of gnodev running locally on your machine 
-  `$(gp url 8888)/r/nubular24/gnodev` in case of gnodev running on gitpod
