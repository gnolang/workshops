package bar20

import "gno.land/r/demo/grc20reg"

var Bank, adm = grc20.NewBank("Bar", "BAR", 4)

var UserBanker = grc20.PrevRealmBanker(Bank)

func init() {
	grc20reg.Register(Bank, "")
}

func Faucet() string {
	caller := std.GetOrignCaller()
	if err := adm.Mint(caller, 1_000_000); err != nil {
		return "error: " + err.Error()
	}
	return "OK"
}
