package users

var admin = "g1xxxxx..."

var invites avl.Tree // std.Address -> true

func AdminSendInvite(address std.Address) {
	if caller := std.GetOrigCaller(); caller != admin {
		panic("unauthorized")
	}
	invites.Set(address, true)
}

func Register() {
	caller := std.GetOrigCaller()
	if !invites.Has(caller) {
		panic("caller hasn't been invited")
	}
	// ... register caller
	invites.Remove(address)
}
