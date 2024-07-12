# Gnoverflow: Phase 2

**Implementation Goals:**
- Define the `Question` model. It should contain the following:
	- ID
	- Title
	- Text
	- Author address
	- Creation time
	- Last updated time
- Create a function to post a question
- Create a function to modify a question's title and/or text
	- Questions can only be modified by their author
- Fully implement `Render` to return the list of all asked questions

Search for `TODO:` in the code to easily navigate to places to add code that
will complete the goals outlined above.

**Resources:**
Check out our [standard library reference docs](https://docs.gno.land/reference/stdlibs) to help complete this exercise.

**Testing:**
- Run `gnodev *` from this directory to spin up the local node
- Navigate to the realm via the browser and verify rendering is working
- Post a couple of questions using `gnokey` to call the function you created to post a question
- Verify that these questions are being rendered correctly.
- Modify a question
- Verify the question was modified