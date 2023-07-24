// r/system/config: contributors DAO votes for chain configuration changes (runtime limits, etc)
func Propose() {}
func Apply{} 

// baseapp: the baseapp subscribes to changes happening in the contract
sdk.Subscribe(configChangedFilterFn, applyConfigChange)

// baseapp: to fetch the expected configuration
sdk.GetRealm("r/system/config").GetState("chainCfg")

// baseapp: during abci.EndBlocker
bft.XXX(opts...)

