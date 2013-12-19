Feature: Upvote or downvote posts.
	As a knowledge seeker
	So that I can help promote quality posts
	I want to vote on posts

	Background:
		Given the following users have been created:
			| id	   | name				| email				| linkedin_id	|
			| 0		| User Alpha	   | q@w.net			| sdlgik3		|
		And the following posts have been created:
			| user_id   | title			|	created_on			| content						|
			| 1			| Red Post		|	2013-11-01			|	This is the post			|

	@javascript
	Scenario: Voting before logging in
		Given I am on the homepage
      When I click the button named "upvote" within "post-1"
      Then I should see "Please log in to complete this action."

	@javascript
	Scenario: Upvote a post
		Given I am on the homepage
		When I log in with "jdoe@alumino.us" and "cr4zyP4zzwurd"
		When I click the button named "upvote" within "post-1"
		Then I should see "Voted!"

	@javascript
	Scenario: Vote twice on a post
		Given I am on the homepage
		When I log in with "jdoe@alumino.us" and "cr4zyP4zzwurd"
		When I click the button named "downvote" within "post-1"
		Then I should see "Voted!"
		When I click the button named "downvote" within "post-1"
		Then I should see "You already voted!"

