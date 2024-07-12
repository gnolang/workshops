# Gnoverflow: Phase 3

**Implementation Goals:**
- Define the `Answer` model. It should contain the following:
	- ID
	- Text
	- Author address
	- Creation time
	- Last updated time
- Create a function to post an answer
- Create a function to modify an answer
	- Answers can only be modified by their author
- Modify the `Render` function to display answers below each question

Search for `TODO:` in the code to easily navigate to places to add code that
will complete the goals outlined above.

**Considerations:**
- How should the answers be stored?

**Testing:**
- Run `gnodev *` from this directory to spin up the local node
- Post a question and then an answer to the question
- Try multiple questions and multiple answers
- Verify they are being rendered correctly
- Update and answer
- Verify the answer was modified