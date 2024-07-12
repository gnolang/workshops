# Gnoverflow: Phase 4

**Implementation Goals:**
- Define a moderator
	- The default address of the moderator should be the address that creates the gnoverflow package
	- Only moderator can change the moderator to another address
	- The moderator can lock and unlock questions and answers
		- Locked questions and answers can't be updated
		- Locked questions shouldn't accept answers
	- The moderator can update any question and answer
- Add the concept of upvotes
	- Both questions and answers can be upvoted
	- Only one upvote is allowed by each address for each question / answer
	- An upvote should be automatically applied from the address creating a new question / answer
- Modify the `Render` function to display if a question or answer is locked
- Modify the `Render` function to display the number of upvotes for each question and each of its answers

No more `TODO:` labels going forward 😭
You can do it!

**Considerations:**
- How should the initial value of the moderator be assigned?
- How should upvotes be stored?
	- There is a package similar to `gno.land/p/demo/uintavl` called `gno.land/p/demo/avl` that used a string as a key value
	- `std.Address` types have a `String()` method

**Testing:**
- Run `gnodev *` from this directory to spin up the local node
- Post a question and answer from a non-moderator address
- Lock a question as the moderator and verify that answers are not accepted
- Try to update locked questions and answers and verify updates are not accepted
- Add upvotes to questions and answers and verify they are rendered correctly
- Verify that an address cannot upvote questions and answers more than once