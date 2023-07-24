// r/system/config: contributors DAO votes for chain configuration changes (runtime limits, etc)
func Propose() {}
func Apply() {}

// baseapp: the baseapp subscribes to changes happening in the contract
sdk.Subscribe(valsetChangedFilterFn, applyValsetFn)

// baseapp: to fetch the expected configuration
updates := sdk.GetRealm("r/system/validators").GetState("updates")

// baseapp: during abci.EndBlocker
bft.ValidateValidatorUpdates(updates)
