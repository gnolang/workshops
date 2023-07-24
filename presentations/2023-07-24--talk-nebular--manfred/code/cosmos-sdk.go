package keeper // OMIT
// cli/cli.go, msg.go, handler.go, >keeper.go<
//  * keeper/handler pattern, "ctx", binary codec, determinism
import (
	"strconv" // OMIT
	// OMIT
	"github.com/gnolang/gno/pkgs/sdk"
)

type Keeper struct{ storeKey storetypes.StoreKey } // expected to be prefix store.

func (k *Keeper) Incr(sdk.Context) {
	store := ctx.KVStore(k.storeKey)
	bz := store.Get("x")
	if bz == nil {
		panic("XXX")
	}
	x, err := strconv.Atoi(bz)
	if err != nil {
		panic("XXX")
	}
	x += 1 // all we wanted // HL
	bz = strconv.Itoa(x)
	store.Set("x", bz)
}
