package party

import (
	"std"
	"time"
)

// Party holds single party information
type Party struct {
	owner       std.Address   // the organizer of the party
	name        string        // the name of the party
	description string        // description about the party
	time        time.Time     // time of the party
	guests      []std.Address // list of RSPVd guests
}

// NewParty creates a new party
func NewParty(name string, description string, start int64) *Party {
	return &Party{
		owner:       std.GetOrigCaller(),
		name:        name,
		description: description,
		time:        time.Unix(start, 0),
		guests:      make([]std.Address, 0),
	}
}

// GetName returns the party name
func (p *Party) GetName() string {
	return p.name
}

// GetDescription returns the party description
func (p *Party) GetDescription() string {
	return p.description
}

// GetTime returns the party start
func (p *Party) GetTime() time.Time {
	return p.time
}

// GetGuests returns the RSVPd guest list for the party
func (p *Party) GetGuests() []std.Address {
	return p.guests
}

// AddGuest adds a new guest to the party.
// Returns a flag indicating if the guest was added
func (p *Party) AddGuest(guest std.Address) bool {
	// Check that the method caller is the organizer of the party
	if !p.isOwner(std.GetOrigCaller()) {
		return false
	}

	// Append the guest
	p.guests = append(p.guests, guest)

	return true
}

// isOwner checks if the address belongs to the owner
func (p *Party) isOwner(address std.Address) bool {
	return address.String() == p.owner.String()
}
