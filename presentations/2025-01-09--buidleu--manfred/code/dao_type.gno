// gno.land/p/dao
package dao

type DAO interface {
	// Core proposal operations
	Propose(def PropDefinition) (Proposal, error)
	GetProposal(proposalID uint64) (Proposal, error)
	Execute(proposalID uint64) error

	// List operations
	ActiveProposals() PropList
	ArchivedProposals() PropList
	Len() int
}
