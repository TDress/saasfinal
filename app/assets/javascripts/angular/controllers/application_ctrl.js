function ApplicationCtrl($rootScope, $scope, CookieStore, Session) {
   $scope.welcomeBannerDismissed = CookieStore.get('welcomeBannerDismissed');
   $rootScope.warnings = $rootScope.warnings || [];

   $scope.closeWelcomeBanner = function() {
      $scope.welcomeBannerDismissed = true;
      CookieStore.put('welcomeBannerDismissed', $scope.welcomeBannerDismissed, new Date(9999999999999));
   }

   $scope.Session = Session

   $rootScope.$on('loginSuccess', function(event, user) {
      window.location.reload();
   })

   $rootScope.$on('loginFailure', function(event, error) {
      $scope.warnings.push(error.error_description);
   })
}

