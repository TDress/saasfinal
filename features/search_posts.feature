Feature: View posts list on the home page, and expand posts for more detail.
	As a knowledge seeked
	So that I can find knowlege that is personally relavant
	I want to view and search a list of posts

	Background:
		Given the following users have been created:
			| id	   | name				| email				| linkedin_id	|
			| 0		| User Alpha	   | q@w.net			| sdlgik3		|
			| 1		| User Beta		   | a@b.com			| w944g3			|
		And the following posts have been created:
			| user	   | title			|	created_on			| content						|
			| 1			| Red Post		|	2013-11-01			|	Maroon content		|
			| 0			| Blue Post		|	2012-10-01			|	Ocean content	|
			| 1			| Green Post		|	2013-11-01			|	Forest content			|
			| 1			| Orange Post		|	2013-11-01			|	Pumpkin content			|
			| 0			| Gold Post		|	2012-10-01			|	Sun content	|					
			| 1			| Black Post		|	2013-11-01			|	Night content			|
			| 0			| Purple Post		|	2012-10-01			|	Magenta content	|

	@javascript
	Scenario: View posts list
		When I am on the homepage
		And I enter "Night" in the "Search" field
		And I wait "5" seconds
		Then I should see "Black Post"
		And I should not see "Red Post, Blue Post, Green Post, Orange Post, Gold Post, Purple post" 
		
