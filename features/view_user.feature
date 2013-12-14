Feature: View User Profile 
	As a user,
	So that I can learn more about a user and see other posts made by that user,
	I want to be able to view a user's profile by clicking on their name next to a post.

	Background:
		Given I am on the homepage
		And the following users have been created:
			| id	| name				| email				| linkedin_id	|
			|	0		| User Alpha	| q@w.net			| sdlgik3			|
			| 1		| User Beta		|	a@b.com			| w944g3			|
		And the following posts have been created:
			|	user	| title				|	created_on			| content									|
			| 1			| Red Post		|	2013-11-01			|	This is the post				|
			| 0			| Blue Post		|	2012-10-01			|	This is the other post	|
		
	@javascript
	Scenario: Click on a user and view their profile.
		When I click the "User Alpha" link
		Then I should see "Here are the posts made by User"
		And I should see "Check me out!"
