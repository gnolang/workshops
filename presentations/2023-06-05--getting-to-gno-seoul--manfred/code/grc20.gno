package demo // OMIT
import (
	"std"  // OMIT
	// OMIT
	"gno.land/p/demo/grc/grc20" 
)

var Token *grc20.Token

func init() {
	minter := grc20.NewAdminToken("Foo", "FOO", 4)
	minter.Mint("g1u7y667z64x2h7vc6fmpcprgey4ck233jaww9zq", 10_000*10_000)
	Token = minter.GRC20() // expose an unprivileged token
}
