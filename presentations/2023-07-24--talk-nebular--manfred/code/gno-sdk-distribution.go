// baseapp: chain fees (gas) are sent to `sdk.GetRealm("r/system/rewards").Banker`

// r/system/rewards: distribution logic implemented in contract,
// querying other contracts, applying rules
import "gno.land/r/system/validators"
import "gno.land/r/gnoland/dao"
func Distribute() {
	// split
}

// baseapp: relevant chain event (double sig, etc) can be sent to the contract
r.GetRealm("r/system/rewards").Send(abci.Event{})
