package aggregateddao

import "gno.land/p/dao"

type AggregatedDAO struct { dao1, dao2 dao.DAO }

func (a *AggregatedDAO) Propose(def dao.PropDefinition) (dao.Proposal, error) {
	prop1, _ := a.dao1.Propose(def)
	prop2, _ := a.dao2.Propose(def)
	// [...]
}

func (a *AggregatedDAO) Len() int { return a.dao1.Len() + a.dao2.Len() }

func (a *AggregatedDAO) ActiveProposals() dao.PropList {
	return append(a.dao1.ActiveProposals(), a.dao2.ActiveProposals()...)
}

func (a *AggregatedDAO) ArchivedProposals() dao.PropList {
	return append(a.dao1.ArchivedProposals(), a.dao2.ArchivedProposals()...)
}

// [...]
