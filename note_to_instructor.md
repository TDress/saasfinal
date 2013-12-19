# Note to Instructor, From Thomas Dressler and Austin Brown

### Deviations from Original Proposal
* We did not implement a threshold where only highly rated posts are added to the "knowledge base".  All posts are included in results from searching, filtering and sorting.  In the absence of user feedback and preliminary usability testing, implementing this feature seemed unnecessary.

### Features Outside of Rails
* Javascript framework [AngularJS](http://angularjs.org/) for client-side routing, rendering, and data retrieval. The client-side Angular application code is in `app/assets/javascripts/angular/*`.
* [AngularUI Router](https://github.com/angular-ui/ui-router) for creating 'state' properties around views and nested views.
* [Bootstrap](http://getbootstrap.com/) for styles and effects.
* [Selenium WebDriver](http://www.seleniumhq.org/) for automated testing of pages that rely on JavaScript.
* OAuth login with LinkedIn. The login process is handled by `app/controllers/session_controller.rb`. `lib/linkedin.rb` contains a minimal ruby interface to the LinkedIn API. If the user has a profile image on LinkedIn, this will also be imported during login.

