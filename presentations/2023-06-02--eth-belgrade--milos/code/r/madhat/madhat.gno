package madhat

import (
	"bytes"
	"std"

	"gno.land/p/demo/avl"
	"gno.land/p/demo/party"
	"gno.land/p/demo/ufmt"
)

var (
	owner   std.Address = "g1wxkyp3v9w4llp5tyyr64a8ly532dzvd3z57wy6" // the owner address; subject to change
	parties *avl.Tree                                                // maps party ID -> party
)

// The Realm constructor method
func init() {
	parties = avl.NewTree()
}

// isOwner checks that the caller is the realm owner
func isOwner() bool {
	return std.GetOrigCaller().String() == owner.String()
}

// NewTeaParty creates a new Mad Hatter Tea Party
func NewTeaParty(name string, description string, time int64) (int, string) {
	// Check if the owner is creating the party
	if !isOwner() {
		return 0, "unable to create party"
	}

	// Create the party
	party := party.NewParty(name, description, time)

	// Grab the latest ID
	id := parties.Size()

	// Update the global party set
	parties.Set(
		ufmt.Sprintf("%d", id),
		party,
	)

	// Return the ID to the user
	return id, "successfully created party"
}

// RSVP notes the caller as "going" to the Mad Hatter Tea Party
func RSVP(partyID int) string {
	// Get the caller address
	rsvpGuest := std.GetOrigCaller()

	// Get the party ID as a number
	id := ufmt.Sprintf("%d", partyID)

	// Make sure the party exists
	partyRaw, found := parties.Get(id)
	if !found {
		return "party not found"
	}

	// Get the party object
	party, _ := partyRaw.(*party.Party)

	// Make sure the guest has not already RSVPd
	for _, guest := range party.GetGuests() {
		if guest.String() == rsvpGuest.String() {
			return "guest already RSVPd"
		}
	}

	// Add the guest to the party
	party.AddGuest(rsvpGuest)

	// Save the updated party
	parties.Set(
		id,
		party,
	)

	return "guest successfully RSVPd"
}

// Render displays the party's content
func Render(path string) string {
	if path == "" {
		// The base path is requested
		return renderHomepage()
	}

	return "unknown party page"
}

// renderHomepage outputs the Realm state as Markdown
func renderHomepage() string {
	var b bytes.Buffer

	// Write welcome message
	b.WriteString("## Welcome to the Mad Hatter Tea Parties!\n\n")

	if parties.Size() == 0 {
		// No parties available
		b.WriteString("### No parties found :(")

		return b.String()
	}

	// For each category, write the name
	parties.Iterate("", "", func(key string, value interface{}) bool {
		// Write out the party details
		party := value.(*party.Party)

		b.WriteString(
			ufmt.Sprintf(
				"## %s: %s - %s\n",
				key, // party ID
				party.GetName(),
				party.GetTime().Format("02.01.2006. 15:04"),
			),
		)
		b.WriteString(
			ufmt.Sprintf("%s\n\n", party.GetDescription()),
		)

		// Print guest list
		if guests := party.GetGuests(); len(guests) > 0 {
			b.WriteString(
				ufmt.Sprintf("### Guests (%d):\n", len(guests)),
			)

			for index, guest := range guests {
				b.WriteString(
					ufmt.Sprintf("#%d - %s\n", index, guest),
				)
			}
		} else {
			b.WriteString("_No guests coming...yet_\n")
		}

		b.WriteString("\n")

		// Continue iteration
		return false
	})

	return b.String()
}
