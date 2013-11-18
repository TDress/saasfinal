function PostIndexCtrl($scope, Post) {
   $scope.posts = Post.query({})
}
