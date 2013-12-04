Feature: Sessions with LinkedIn connected authentication
	As a LinkedIn user
	So that I can associate my account with my existing profile
	I want to log in with LinkedIn

	@javascript
	Scenario: Log in with LinkedIn
		Given I am on the homepage
		Then there should be a button called "logIn"
		When I log in with "jdoe@alumino.us" and "cr4zyP4zzwurd"
		Then there should be a button called "logOut"

	@javascript
	Scenario: Denied connection with LinkedIn
		Given I am on the homepage
		Then there should be a button called "logIn"
		When I try to log in but deny permission when LinkedIn asks
		Then there should be a button called "logIn"

	@javascript
	Scenario: Log out
		Given I am on the homepage
		And I log in with "jdoe@alumino.us" and "cr4zyP4zzwurd"
		And I click "logOut"
		Then there should be a button called "logIn"
		And there should not be a button called "logOut"
