package dex

func (dex *DEX) matchPairOrders(tokenFrom, tokenTo *grc20.Bank) int {
	matched := 0
	orders.Iterate("", "", func(key1 string, value interface{}) bool {
		orders.Iterate("", "", func(key2 string, value2 interface{}) bool {
			if order1.isBuy != order2.isBuy && order1.tokenFrom == order2.tokenTo && order1.tokenTo == order2.tokenFrom {
				amount := min(order1.amount, order2.amount)
				order1.amount -= amount
				order2.amount -= amount
				banker1 := grc20.AccountBanker(order1.tokenFrom, "")
				banker2 := grc20.AccountBanker(order2.tokenFrom, "")
				banker1.Transfer(order2.trader, amount)
				banker2.Transfer(order1.trader, amount)
				matched++
				std.Emit("trade_executed" /*...*/)
			}
		})
	})
	return matched
}
