Feature: View posts list on the home page, and expand posts for more detail.
	As a knowledge seeker
	So that I can find knowlege that is personally relavant
	I want to view and search a list of posts

	Background:
		Given the following users have been created:
			| id	   | name				| email				| linkedin_id	|
			| 0		| User Alpha	   | q@w.net			| sdlgik3		|
			| 1		| User Beta		   | a@b.com			| w944g3			|
		And the following posts have been created:
			| user	   | title			|	created_on			| content						|
			| 1			| Red Post		|	2013-11-01			|	This is the post			|
			| 0			| Blue Post		|	2012-10-01			|	This is the other post	|

	@javascript
	Scenario: View posts list
		When I am on the homepage
		Then I should see "Red Post" before "Blue Post"
