package bob

import "alice"

func IncrAlice() {
	x := alice.GetX()
	alice.SetX(x + 1)
}
