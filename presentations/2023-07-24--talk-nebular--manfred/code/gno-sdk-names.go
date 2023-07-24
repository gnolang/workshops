// baseapp: hook when `AddPkg` is called in a transaction
sdk.Subscribe(filterFn, callbackFn)

// baseapp: if realm does not exist, skip validation
if !sdk.HasRealm("r/system/names") {
	return true
}

// baseapp: returns list of available personal and team namespaces (manfred, gnocore, teamfoo)
sdk.GetRealm("r/system/names").Call("GetGroups", "manfred")

// baseapp: if namespace matches
if matches {
	return true
}
