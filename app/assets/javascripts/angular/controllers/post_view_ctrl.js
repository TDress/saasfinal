function PostViewCtrl($scope, $modal, PostTag) {
   var shown = false; // Has the post ever been expanded?
   $scope.postCollapsed = true;

   $scope.toggleCollapsed = function() {
      $scope.postCollapsed = !$scope.postCollapsed;

      if (!shown) {
         shown = true;
         $scope.$broadcast("postExpanded");
      }
   }

   $scope.addTag = function() {
      function addTagSuccess(tag) {
         $scope.post.post_tags.push(tag);
         dialog.close();
      }

      var dialog = $modal.open({
         templateUrl: '/templates/popups/tag.html',
         scope: $scope,
         controller: function($scope) {
            $scope.tags = []
            $scope.newTag = new PostTag({post_id: $scope.post.id});
            $scope.post = $scope.$parent.post

            $scope.$watch('newTag', ratelimit(function(keywords) {
               return $scope.tags = PostTag.query({keywords: keywords});
            }, 300));

            $scope.addTag = function() {
               return $scope.newTag.$save(function() {
                  $scope.errorMessage = '';
                  $scope.post.post_tags.push($scope.newTag);
                  $scope.newTag = new PostTag({post_id: $scope.post.id});
               }, function(e) {
                  $scope.errorMessage = e.data.error || "Failed to save tag. Please try again later."
               });
            }
         }
      })
   }
}
