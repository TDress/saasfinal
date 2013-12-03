function ApplicationCtrl($scope, CookieStore) {
   $scope.welcomeBannerDismissed = CookieStore.get('welcomeBannerDismissed');

   $scope.closeWelcomeBanner = function() {
      $scope.welcomeBannerDismissed = true;
      CookieStore.put('welcomeBannerDismissed', $scope.welcomeBannerDismissed, new Date(9999999999999));
   }

   $scope.logIn = function() {
      window.open('/session/create')
   }
}
