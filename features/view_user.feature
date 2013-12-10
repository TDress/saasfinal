Feature: View User Profile 
	As a user,
	So that I can learn more about a user and see other posts made by that user,
	I want to be able to view a user's profile by clicking on their name next to a post.

	Background:
		Given I am on the homepage
		
	@javascript
	Scenario: Click on a user and view their profile.
		When I click "Russell Gilbert"
		Then I should see "Here are the posts made by Russell"
		And I should see "Check me out!"
