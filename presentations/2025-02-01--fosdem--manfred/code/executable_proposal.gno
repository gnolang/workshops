// prop1.gno

import "gno.land/r/gov/dao"
import "gno.land/r/buidl/buidl20"

func init() {
	closure := func() error {
		// this closure will preserve the execution context at the time of
		// creation, even if the proposal is executed by someone else.
		return executor()
	}
	prop := dao.ProposalRequest{
		Title:       "",
		Description: "lorem ipsum dolor sit amet",
		Executor:    closure,
	}
	dao.Propose(prop)
}

func executor() error {
  buidl20.TransferTo("g12345678", 1_000_000) // transfer 1M $BUIDL
  return nil
}
