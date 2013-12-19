/*
 * The top posts functionality is not implemented yet; in the meantime top posts 
 * are showing as current posts in reverse order. 
 */
function UserViewCtrl($scope, User, Post, $stateParams) {
	$scope.user = User.query({user_id: $stateParams.user_id}, function() {
		$scope.firstname = /(.*)\s/.exec($scope.user.name)[1];
	});
	
	// Query the Posts model for (sorted) top-rated and recent posts created by this user
	$scope.top_posts = Post.query({user_id: $stateParams.user_id, sortUserPostsBy: 'vote_sum'});
	$scope.current_posts = Post.query({user_id: $stateParams.user_id, sortUserPostsBy: 'created_on'});
	
	
	// Default to top posts
	$scope.userposts = $scope.top_posts;	
	$scope.topPostsButtonActive = 'active';
	$scope.curPostsButtonActive = '';
	
	var getActiveButton = function() {
		$scope.topPostsButtonActive = ($scope.userposts==$scope.top_posts ? 'active' : '');
		$scope.curPostsButtonActive = ($scope.userposts==$scope.current_posts ? 'active' : '');
	}
	
	$scope.$watch('userposts', getActiveButton);
}
