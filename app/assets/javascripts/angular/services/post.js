angular.module('saasfinal.post', ['ngResource'])
   .factory('Post', function($resource) {
      var Post = $resource('/posts.json', {}, {});

      // Override default query functionality
      Post._query = Post.query;
      Post.query = function(params){
         for (key in params) {
            if (typeof params[key] == 'function') {
               // When attempting to send a function as a parameter, send it's return value instead
               params[key] = params[key]();
            }
         }

         return Post._query(params);
      }
      return Post;
   })
