Feature: Leave comments on posts
	As a knowledge seeker
	So that I can share my thoughts about a post with others
	I want to leave a comment on posts

	Background:
		Given the following users have been created:
			| id	   | name				| email				| linkedin_id	|
			| 0		| User Alpha	   | q@w.net			| sdlgik3		|
		And the following posts have been created:
			| user_id   | title			|	created_on			| content						|
			| 1			| Red Post		|	2013-11-01			|	This is the post			|

	@javascript
	Scenario: Opening comments section
      When I am on the homepage
      And I click the link named "openpost" within "post-1"
      And I click the link named "opencomments" within "post-1"
      Then I should see "Please.*Log In.*to leave a comment"

	@javascript
	Scenario: User must log in to comment
      When I am on the homepage
      And I click the link named "openpost" within "post-1"
      And I click the link named "opencomments" within "post-1"
      Then I should see "There aren't any comments yet. Be the first!"
