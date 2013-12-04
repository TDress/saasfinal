angular.module('saasfinal.user', ['ngResource'])
	.factory('User', function($resource) {
		var User = $resource('/users.json', {}, {
			'query': {method: 'GET', isArray: false}
		});
		return User;
	})
