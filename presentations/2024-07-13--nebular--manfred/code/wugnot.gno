package wugnot

import (
	"std"
	"strings"

	"gno.land/p/demo/grc/grc20"
	"gno.land/p/demo/ufmt"
	pusers "gno.land/p/demo/users"
	"gno.land/r/demo/grc20reg"
	"gno.land/r/demo/users"
)

var Bank, adm = grc20.NewBank("wrapped GNOT", "wugnot", 0)

func Deposit() {
	caller := std.PrevRealm().Addr()
	sent := std.GetOrigSend()
	amount := sent.AmountOf("ugnot")
	require(uint64(amount) >= ugnotMinDeposit, ufmt.Sprintf("Deposit below minimum: %d/%d ugnot.", amount, ugnotMinDeposit))
	checkErr(adm.Mint(caller, uint64(amount)))
}

// Withdraw...
