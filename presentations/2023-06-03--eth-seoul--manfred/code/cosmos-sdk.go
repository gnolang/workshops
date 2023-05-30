// cli/cli.go
// msg.go
// handler.go
// keeper.go  <-- here
//  * with binary encoding/decoding of x.
//  * no 'x' variable.
//  * could use Amino-based object store.

type Keeper struct {
  // expected to be prefix store.
  storeKey               storetypes.StoreKey
}

func (k *Keeper) Incr(sdk.Context) {
  store := ctx.KVStore(k.storeKey)
  bz := store.Get("x")
  if bz == nil {
    panic("XXX")
  }
  x, err := strconv.Atoi(bz)

  x += 1 // all we wanted

  if err != nil {
    panic("XXX")
  }
  bz = strconv.Itoa(x)
  store.Set("x", bz)
}