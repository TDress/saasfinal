Feature: Add a new post
	As a user,
	So that I can have a goo UX when contributing to the knowledge base,
	I want to see flash error messages if I make mistakes when adding a post.

	Background:
		Given I am on the homepage
		
	@javascript
	Scenario: Add a new post, leave a required field empty, see flash message
		When I press "Add Post"
		And I enter "New" in the "Title" field
		And I press "Save Post!"
		Then I should see "You must enter content for the new post."
