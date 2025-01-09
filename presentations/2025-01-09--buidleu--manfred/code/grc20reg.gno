// gno.land/r/demo/grc20reg
package grc20reg 

var registry = avl.NewTree() // rlmPath -> TokenGetter

func Register(tokenGetter grc20.TokenGetter) {
	rlmPath := std.PrevRealm().PkgPath()
	registry.Set(rlmPath, tokenGetter)
}

func Get(key string) grc20.TokenGetter {
	tokenGetter, _ := registry.Get(key)
	return tokenGetter
}
