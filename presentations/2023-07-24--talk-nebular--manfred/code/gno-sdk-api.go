// simple chicken-egg problem resolving
if sdk.RealmExists("gno.land/r/demo/foo") {}

// load the realm as a Go object
r := sdk.GetRealm("gno.land/r/demo/foo")

// retrieve the state of a variable without executing the contract, cheap
v, _ := r.GetState("things")

// similar to calling the contract from a transaction, more dynamic but expensive
ret, _ := r.Call("HasAccess", ...args)

// appends an event to contract's incoming queue, consumed later with `evt := <-std.Recv()`
r.Send(abci.Event{...})

// reads events from contract's outgoing queue
e := r.Recv()

// interact with realms' bankers methods
banker := r.Banker.XXX

// subscribe to specific events to trigger actions
sdk.Subscribe(filterFn, callbackFn)
