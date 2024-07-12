// gno.land/p/demo/grc/grc20
package grc20

import (
	"std"

	"gno.land/p/demo/grc/exts"
)

type GRC20 interface {
	exts.TokenMetadata
	TotalSupply() uint64
	BalanceOf(account std.Address) uint64
	Transfer(to std.Address, amount uint64) error
	Allowance(owner, spender std.Address) uint64
	Approve(spender std.Address, amount uint64) error
	TransferFrom(from, to std.Address, amount uint64) error
}
