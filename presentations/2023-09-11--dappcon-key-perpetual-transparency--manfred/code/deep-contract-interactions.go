package foobar

import (
	"gno.land/r/foo20" // a grc20 token
	"gno.land/r/users" // equivalent of ENS
)

func TransferToUsername(username string, amount int) {
	user := users.Lookup(username)
	foo20.Transfer(user.Addr(), amount)
}
