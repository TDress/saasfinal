Feature: Add a new post
	As a user,
	So that I can contribute to the knowledge base,
	I want to be able to add a new post.

	Background:
		Given I am on the homepage
		And I log in with "jdoe@alumino.us" and "cr4zyP4zzwurd"

	@javascript
	Scenario: Add a new post, save it, and view it on the homepage
		When I press "Add Post"
		And I enter "New-Test-Post" in the "Title" field
		And I enter "New" in the "inputPostContent" field
		And I press "Save Post!"
		Then I should see "New-Test-Post"
