function PostViewCtrl($scope) {
   var shown = false; // Has the post ever been expanded?
   $scope.postCollapsed = true;

   $scope.toggleCollapsed = function() {
      $scope.postCollapsed = !$scope.postCollapsed;

      if (!shown) {
         shown = true;
         $scope.$broadcast("postExpanded");
      }
   }
}
