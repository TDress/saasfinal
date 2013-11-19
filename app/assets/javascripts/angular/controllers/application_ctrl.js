function ApplicationCtrl($scope, $cookieStore) {
   $scope.welcomeBannerDismissed = $cookieStore.get('welcomeBannerDismissed');

   $scope.closeWelcomeBanner = function() {
      $scope.welcomeBannerDismissed = true;
      $cookieStore.put('welcomeBannerDismissed', $scope.welcomeBannerDismissed);
   }
}
