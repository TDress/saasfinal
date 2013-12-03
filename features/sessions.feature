Feature: Sessions with LinkedIn connected authentication
	As a LinkedIn user
	So that I can associate my account with my existing profile
	I want to log in with LinkedIn

	@javascript
	Scenario: Log in with LinkedIn
		Given I am on the homepage
		And there is a button called "logIn"
		When I log in with "jdoe@alumino.us" and "cr4zyP4zzwurd"
		Then there should be a button called "logOut"
