angular.module('saasfinal.post', ['ngResource'])
   .factory('Post', function($resource) {
      var Post = $resource('/posts.json', {}, {});

      return Post;
   })
