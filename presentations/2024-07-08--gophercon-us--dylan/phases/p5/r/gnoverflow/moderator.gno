package gnoverflow

import "std"

var moderator = std.PrevRealm().Addr()

func ChangeModerator(newModerator std.Address) {
	assertAddressIsModerator(std.PrevRealm().Addr())
	moderator = newModerator
}

func assertAddressIsModerator(address std.Address) {
	if address != moderator {
		panic("only the moderator can perform this action")
	}
}

func LockQuestion(id uint64) {
	assertAddressIsModerator(std.PrevRealm().Addr())
	question := getQuestion(id)
	question.IsLocked = true
}

func UnlockQuestion(id uint64) {
	assertAddressIsModerator(std.PrevRealm().Addr())
	question := getQuestion(id)
	question.IsLocked = false
}
