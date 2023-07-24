// baseapp: chain fees (gas) are sent to the rewards' banker.
gasDestination := sdk.GetRealm("r/system/rewards").Banker().Addr()

// r/system/rewards: Distribution logic implemented in the contract,
// querying other contracts, applying rules.
import "gno.land/r/system/validators"
import "gno.land/r/gnoland/dao"
func Distribute() {
	// Split rewards among recipients.
}

// Baseapp: Relevant chain events (double sig, etc.) can be sent to the contract.
r.GetRealm("r/system/rewards").Send(abci.Event{})
