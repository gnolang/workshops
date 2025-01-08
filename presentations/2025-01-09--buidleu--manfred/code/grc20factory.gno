package foo20

import (
	"std"
	"strings"

	"gno.land/p/demo/grc/grc20"
	"gno.land/r/demo/grc20reg"
)

var instances avl.Tree // symbol -> instance

func New(name, symbol string, decimals uint, initialMint, faucet uint64) {
	admin := std.PrevRealm().Addr()
	bank := grc20.NewBank(name, symbol, decimals)
	bank.Mint(admin, initialMint)
	inst := instance{bank: bank, admin: ownable.NewWithAddress(admin), faucet: faucet}
	instances.Set(symbol, &inst)
	grc20reg.Register(bank, symbol)
}

func Bank(symbol string) *grc20.Bank {
	return mustGetInstance(symbol).bank
}
