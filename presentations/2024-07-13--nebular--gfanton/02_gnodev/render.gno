package render

var bodyPage = `
# My Gno Realm

### Realms in short:

* Smart contracts in Gno.
* Realms are stateful.
* Realms can own assets (tokens).
* Realms can implement ` + "`" + `Render(path string) string` + "`" + `
  to simplify dapp frontend development by allowing users to request
  markdown renderings from validators and full nodes without a transaction.

### Path

The Render function takes a path argument that can impact its behavior. In
'gnoweb', this argument can be passed by adding ` + "`" + `:<path>` + "`" + ` after the URL.

*Try it, go to [/r/nebular24/gnodev:page-2](/r/nebular24/gnodev:page-2)*

`

func Render(path string) string {
	view := bodyPage

	if path != "" {
		view += "---\n"
		view += "### " + path + "\n"
	}

	return view
}
