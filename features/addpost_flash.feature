Feature: Add a new post
	As a contributor to the knowledge base,
	So that I know whether my post was saved,
	I want to see flash error messages if I make mistakes when adding a post.

	Background:
		Given I am on the homepage
		And I log in with "jdoe@alumino.us" and "cr4zyP4zzwurd"

	@javascript
	Scenario: Add a new post, leave a required field empty, see flash message
		When I press "Add Post"
		And I enter "New" in the "Title" field
		And I press "Save Post!"
		Then I should see "You must enter content for the new post."
