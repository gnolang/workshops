package foodao

import "gno.land/p/dao" // interface

// FooDAO implements the dao.DAO interface.
type FooDAO struct { proposals []dao.Proposal, voters []std.Address }

func (d *FooDAO) Propose(def PropDefinition) (Proposal, error) { /* [...] */ }
func (d *FooDAO) GetProposal(proposalID uint64) (Proposal, error) { /* [...] */ }
func (d *FooDAO) Execute(proposalID uint64) error { /* [...] */ }
func (d *FooDAO) ActiveProposals() PropList { /* [...] */ }
func (d *FooDAO) ArchivedProposals() PropList { /* [...] */ }
func (d *FooDAO) Len() int { /* [...] */ }
