
function UserViewCtrl($scope, User, Post, $stateParams) {
	$scope.user = User.query({user_id: $stateParams.user_id});
	
	// Query the Posts model for (sorted) top-rated and recent posts created by this user
	$scope.top_posts = Post.get_user_posts({user_id: $stateParams.user_id, sortUserPostsBy: 'top'});
	$scope.current_posts = Post.get_user_posts({user_id: $stateParams.user_id, sortUserPostsBy: 'recent'});
	$scope.posts = $scope.top_posts;
}
