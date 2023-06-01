package party

import (
	"std"
	"testing"
	"time"

	"gno.land/p/demo/testutils"
	"gno.land/p/demo/ufmt"
)

func TestParty_New(t *testing.T) {
	var (
		name        = "party name"
		description = "party description"
		partyTime   = time.Now().UnixNano()
	)

	// Set a dummy caller address
	alice := testutils.TestAddress("alice")
	std.TestSetOrigCaller(alice)

	// Create a new party using the provided info
	p := NewParty(name, description, partyTime)

	// Make sure the party info matches
	if p.GetName() != name {
		t.Fatal("invalid party name")
	}

	if p.GetDescription() != description {
		t.Fatal("invalid party description")
	}

	if p.GetTime().UnixNano() != partyTime {
		t.Fatal("invalid party time")
	}

	if !p.isOwner(alice) {
		t.Fatal("invalid party owner")
	}
}

// generateTestAddresses generates mock test addresses
func generateTestAddresses(count int) []std.Address {
	res := make([]std.Address, count)

	for i := 0; i < count; i++ {
		res[i] = testutils.TestAddress(ufmt.Sprintf("addr-%d", i))
	}

	return res
}

func TestParty_Guests(t *testing.T) {
	var (
		name        = "party name"
		description = "party description"
		partyTime   = time.Now().UnixNano()
	)

	// Set a dummy address as the caller
	alice := testutils.TestAddress("alice")
	std.TestSetOrigCaller(alice)

	p := NewParty(name, description, partyTime)

	// Make sure there are no guests
	if len(p.GetGuests()) != 0 {
		t.Fatal("invalid number of guests")
	}

	// Add guests
	mockGuests := generateTestAddresses(10)
	for _, guest := range mockGuests {
		p.AddGuest(guest)
	}

	// Make sure the guests are added
	if len(p.GetGuests()) != len(mockGuests) {
		t.Fatal("invalid number of guests")
	}
}
