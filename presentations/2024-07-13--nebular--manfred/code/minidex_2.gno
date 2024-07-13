package dex

// matchPairOrders matches orders for a given pair.
func (dex *DEX) matchPairOrders(tokenFrom, tokenTo *grc20.Bank) int {
	pair := createPairString(tokenFrom, tokenTo)
	ordersTree, ok := dex.pairs.Get(pair)
	if !ok {
		return 0
	}

	matched := 0
	orders := ordersTree.(*avl.Tree)
	orders.Iterate("", "", func(key1 string, value interface{}) bool {
		order1 := value.(*Order)
		orders.Iterate("", "", func(key2 string, value2 interface{}) bool {
			order2 := value2.(*Order)
			println("@@@@@@@@@@@@@@@", order1.String(), "-------", order2.String())
			if order1.isBuy != order2.isBuy && order1.tokenFrom == order2.tokenTo && order1.tokenTo == order2.tokenFrom {
				amount := min(order1.amount, order2.amount)
				order1.amount -= amount
				order2.amount -= amount
				banker1 := grc20.AccountBanker(order1.tokenFrom, "")
				banker2 := grc20.AccountBanker(order2.tokenFrom, "")
				banker1.Transfer(order2.trader, amount)
				banker2.Transfer(order1.trader, amount)
				matched++
				std.Emit(
					"trade_executed",
					"trader1", order1.trader.String(),
					"trader2", order2.trader.String(),
					"token1", order1.tokenFrom.GetName(),
					"token2", order2.tokenFrom.GetName(),
					"amount", ufmt.Sprintf("%d", amount),
				)
				if order1.amount == 0 {
					orders.Remove(key1)
				}
				if order2.amount == 0 {
					orders.Remove(key2)
				}
				return false
			}
			return true
		})
		return true
	})
	return matched
}
