// https://gno.land/r/moul/x/buidl20$source
package buidl20

import (
	"std"
	"gno.land/p/demo/grc/grc20"
)

// Token: public safe object for composability
// adm:   privileged object for minting
var Token, adm = grc20.NewToken("Buidl", "BDL", 4) 

// grc20 API for the caller
var UserTeller = Token.CallerTeller()

func init() {
     adm.Mint(1_000_000, std.GetOrigCaller()) // mint 1M to the contract deployer.  
}

// optional helpers
// [...]
