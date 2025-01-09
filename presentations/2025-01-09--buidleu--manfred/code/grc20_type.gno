package grc20 // gno.land/p/demo/grc/grc20

type Teller interface {
	TotalSupply() uint64
	BalanceOf(account std.Address) uint64
	Transfer(to std.Address, amount uint64) error
	Allowance(owner, spender std.Address) uint64
	Approve(spender std.Address, amount uint64) error
	TransferFrom(from, to std.Address, amount uint64) error
}

type Token struct {
	name, symbol string
	decimals     uint
	ledger       *PrivateLedger
}

type PrivateLedger struct {
	totalSupply          uint64
	balances, allowances avl.Tree
}

func NewToken(name, symbol string, decs uint) (*Token, *PrivateLedger) { /*...*/ }
