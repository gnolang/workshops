// gno.land/r/demo/grc20factory
package grc20factory

var instances avl.Tree // symbol -> instance

type instance struct {
	token  *grc20.Token
	ledger *grc20.PrivateLedger
	admin  *ownable.Ownable
	faucet uint64 // per-request amount. disabled if 0.
}

func New(name, symbol string, decimals uint, initialMint, faucet uint64) {
	caller := std.PrevRealm().Addr()
	token, ledger := grc20.NewToken(name, symbol, decimals)
	if initialMint > 0 {
		ledger.Mint(admin, initialMint)
	}
	owner := ownable.NewWithAddress(admin)
	inst := instance{token: token, ledger: ledger, admin: owner, faucet: faucet}
	instances.Set(symbol, &inst)
	grc20reg.Register(token.Getter(), symbol)
}
