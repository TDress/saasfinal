# Note to Instructor

### Deviations from Original Proposal
* We did not implement a "knowedge base" that only includes highly rated posts.  All posts are inlcuded in results from searching, filtering and sorting.  We made this decision because it seemed unnecessary without first doing usability testing or gathering user feedback.

### Features Outside of Rails
* Javascript framework [AngularJS](http://angularjs.org/) for controlling views and making ajax calls.  You will find Angular controllers in app/assets/javascripts/angular/controllers.
* [AngularUI Router](https://github.com/angular-ui/ui-router) for creating 'state' properties around views and nested views.
* [Bootstrap](http://getbootstrap.com/) for styling and effects.
* [Selenium WebDriver](http://www.seleniumhq.org/) for automating browser during testing.
* OAuth login with LinkedIn. You will find much of the logic for this in app/controllers/session_controller.rb. If the user has a profile image on LinkedIn, this will be imported automatically.
