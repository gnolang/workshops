package grc721

type IGRC721 interface {
	BalanceOf(owner std.Address) (uint64, error)
	OwnerOf(tid TokenID) (std.Address, error)
	SafeTransferFrom(from, to std.Address, tid TokenID) error
	TransferFrom(from, to std.Address, tid TokenID) error
	Approve(approved std.Address, tid TokenID) error
	SetApprovalForAll(operator std.Address, approved bool) error
	GetApproved(tid TokenID) (std.Address, error)
	IsApprovedForAll(owner, operator std.Address) bool
}
