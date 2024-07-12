# Gnoverflow: Phase 5

**Implementation Goals:**
- Allow bounties to be set when posting a question
	- The bounty is the amount sent when calling the function
	- The bounty is paid out when either the question author or moderator marks the question as resolved
	- Resolved questions can't be modified
- Improve `Render` to only render partial question data
	- Clicking on the title should load a new page that renders the full question and answers
- Include the bounty in rendered questions if a bounty exists

**Resources:**
- [std.GetOrigSend](https://docs.gno.land/reference/stdlibs/std/chain#getorigsend) can be used to get and coins sent to the realm (and potentially saved for later use?)
- A [banker](https://docs.gno.land/reference/stdlibs/std/banker) of type `BankerTypeRealmSend` enables coins to be sent from a realm to an address
- We have been using `std.PrevRealm` to get the caller's address. `std.CurrentRealm` can be used to get the realm's address, just in case the banker need's this 😉
- The [faucet realm](https://github.com/gnolang/gno/tree/master/examples/gno.land/r/gnoland/faucet) contains examples of how to use the banker to send coins from a realm to an address
- A note on links returned by `Render`
	- Links to realms can optionally contain a suffix like `:<arguments>`.
	- For example a link to `gnoverflow` might be `/r/gc24/gnoverflow:questions/0`
	- Clicking a link in the browser to navigate to this resource would result in the realm's `Render` function being called with an argument of `questions/0`. 

**Testing:**
- Run `gnodev *` from this directory to spin up the local node
- Post a question with a bounty
	- Confirm the balance of the realm has increased and the balance of the caller has decreased
	- The realm's address is `g1032dtg8dwd9vj50c9psrjs7a6vj9n0ahk8etkz`
	- Query balances by running `gnokey query bank/balances/<address>`
- Mark a question as resolved and verify the balance updates
	- The realm balance has decreased
	- The account that posted the accepted answer has had its balance increased
- Open the web UI and verify that question titles can be clicked to open a new page that renders the full question and its answers