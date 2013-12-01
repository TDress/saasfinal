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

function PostIndexCtrl($scope, Post, $stateParams) {
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
            orderBy: 'votes_sum'
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

   // Search parameters that can be sent as the user inputs them (not sorts and dates)
   $scope.simpleParams = {
      keywords: ""
   };

   var refreshPosts = function() {
      // Copy all search parameters into one object to query server
      searchParams = $.extend({}, $scope.timeMode.params, $scope.sortMode.params, $scope.simpleParams)

      $scope.posts = Post.query(searchParams);
   };

   // Load initial posts
   refreshPosts()

   $scope.$watch('timeMode', refreshPosts)
   $scope.$watch('simpleParams', ratelimit(refreshPosts), true)
   $scope.$watch('sortMode', refreshPosts)


}
