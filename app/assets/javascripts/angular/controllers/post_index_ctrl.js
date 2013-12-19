/**
 * Create a function that returns a time from fixed number of seconds in the past
 * @param sec Seconds to subtract from the current time when called
 * @returns {Function} Function which returns a time sec seconds in the past
 */
function secondsAgo(sec) {
   return function() {
      return Date.now()/1000 - sec;
   }
}

function PostIndexCtrl($scope, $stateParams, Post, PostTag) {
   if($stateParams.addsuccess) {
		 $scope.message = $stateParams.addsuccess;
		 $scope.addPostSuccessFlash = true;
   }

   $scope.sortModes = [
      {
         name: "Most Recent",
         params: {
            orderBy: 'created_on'
         }
      },
      {
         name: "Highest Rated",
         params: {
            orderBy: 'vote_sum'
         }
      },
      {
         name: "Most Discussed",
         params: {
            orderBy: 'comments_total'
         }
      }
   ];
   $scope.sortMode = $scope.sortModes[0];

   $scope.timeModes = [
      {
         name: "Any Time",
         params: {
            createdAfter: 0
         }
      },
      {
         name: "Past Hour",
         params: {
            createdAfter: secondsAgo(3600)
         }
      },
      {
         name: "Past Day",
         params: {
            createdAfter: secondsAgo(3600*24)
         }
      },
      {
         name: "Past Week",
         params: {
            createdAfter: secondsAgo(3600*24*7)
         }
      },
      {
         name: "Past Month",
         params: {
            createdAfter: secondsAgo(3600*24*30)
         }
      },
      {
         name: "Past Year",
         params: {
            createdAfter: secondsAgo(31557600)
         }
      }
   ];
   $scope.timeMode = $scope.timeModes[0];

   // Search parameters that can be sent without processing (not sorts and dates)
   $scope.simpleParams = {
      keywords: ""
   };

   // Load more posts and append them to the post list
   $scope.loadPosts = function() {
      $scope.stopLoadPosts = true;

      // Copy all search parameters into one object to query server
      searchParams = $.extend({
         offset: $scope.posts.length,
         limit: 15
      }, $scope.timeMode.params, $scope.sortMode.params, $scope.simpleParams);

      var result = Post.query(searchParams);
      result.$promise.then(function(newPosts, headers) {
         newPosts.forEach(function(newPost) {
            $scope.posts.push(newPost);
         });

         if (newPosts.length < 10) {
            $scope.stopLoadPosts = true
            $scope.endMessage = $scope.posts.length ? "No more results." : "No results found."
         }

         $scope.stopLoadPosts = false;
      }, function(httpResponse) {
         console.error("Error loading posts:", httpResponse);
         $scope.endError = "There was an error loading the posts. Please refresh the page.";
      });
   }

   // Clear the post list and reload
   function reloadPosts(newParams, oldParams) {
      // Ignore spurious $watch events while loading initial posts.
      if ($scope.posts && newParams === oldParams) return;

      $scope.posts = [];
      $scope.stopLoadPosts = false;

      $scope.loadPosts();
   };

   // Get a list of tags containing parital for autocompletion
   function completeTags() {
      return $scope.tags = PostTag.query({
         keywords: $scope.simpleParams.keywords
      })
   }

   // Keep list of posts up to date
   $scope.$watch('timeMode', reloadPosts)
   $scope.$watch('simpleParams', ratelimit(reloadPosts, 1000), true)
   $scope.$watch('sortMode', reloadPosts)

   // Keep autocomplete list up to date
   $scope.$watch('simpleParams.keywords', ratelimit(completeTags, 300))
}
