package dex

func (dex *DEX) PlaceOrder(tokenFrom, tokenTo grc20.Token, amount uint64, isBuy bool) int {
	trader, contract := std.PrevRealm().Addr(), std.CurrentRealm().Addr()
	userBanker := grc20.AccountBanker(tokenFrom, "")

	allowance := userBanker.Allowance(trader, contract)
	require(allowance >= amount, "insufficient allowance")
	err := userBanker.TransferFrom(trader, contract, amount)
	checkErr(err, "cannot retrieve tokens from allowance")

	order := &Order{trader: trader, tokenFrom: tokenFrom, tokenTo: tokenTo, amount: amount, isBuy: isBuy}
	dex.Append(order)
	std.Emit(
		"order_placed",
		"trader", trader.String(),
		"tokenFrom", tokenFrom.GetName(),
		"tokenTo", tokenTo.GetName(),
		"amount", ufmt.Sprintf("%d", amount),
	)

	return dex.matchPairOrders(tokenFrom, tokenTo)
}
