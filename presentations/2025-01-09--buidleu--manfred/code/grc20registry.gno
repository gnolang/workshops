package grc20reg

import (
	"std"

	"gno.land/p/demo/grc/grc20"
)

var registry = avl.NewTree() // rlmPath[.slug] -> *grc20.Bank

func Register(bank *grc20.Bank, slug string) {
	rlmPath := std.PrevRealm().PkgPath()
	key := fqname.Construct(rlmPath, slug)
	registry.Set(key, bank)
	std.Emit(registerEvent, "pkgpath", rlmPath, "slug", slug)
}

func Get(key string) *grc20.Bank {
	bank, ok := registry.Get(key)
	if !ok {
		return nil
	}
	return bank.(*grc20.Bank)
}
