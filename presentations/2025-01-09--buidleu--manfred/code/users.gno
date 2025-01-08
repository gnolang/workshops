package users

var (
	addressToUsers avl.Tree // address -> user
	usersToAddress avl.Tree // user -> address
)

func Register(name string) {
	caller := std.GetOrigCaller()
	if usersToAddress.Has(name) || addressToUsers.Has(caller) {
		panic("address/name already registered")
	}

	usersToAddress.Set(name, std.GetOrignCaller())
	addressToUsers.Set(std.GetOrignCaller(), name)
}
