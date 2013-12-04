function ApplicationCtrl($rootScope, $scope, CookieStore) {
   $scope.welcomeBannerDismissed = CookieStore.get('welcomeBannerDismissed');
   $rootScope.loggedIn = CookieStore.get('userId');
   $rootScope.warnings = $rootScope.warnings || [];

   $scope.closeWelcomeBanner = function() {
      $scope.welcomeBannerDismissed = true;
      CookieStore.put('welcomeBannerDismissed', $scope.welcomeBannerDismissed, new Date(9999999999999));
   }

   $scope.logIn = function() {
      loginPopup = window.open('/session/create', 'loginPopup', 'width=480,height=640,left=' +
         ((window.screen.availWidth/2)-240));
      if (window.focus) {
         loginPopup.focus();
      }
   }

   $scope.logOut = function() {
      window.location = "/session/destroy";
   }

   $rootScope.$on('loginSuccess', function(event, user) {
      window.location.reload();
   })

   $rootScope.$on('loginFailure', function(event, error) {
      $scope.warnings.push(error.error_description);
   })
}
