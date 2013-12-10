angular.module('saasfinal.widgets', ['saasfinal.post'])
   /**
    * An element that self-destructs after a delay. Useful for status messages.
    */
   .directive('flash', function() {
      return {
         restrict: 'E',
         link: function(scope, element, attrs) {
            window.setTimeout(function(){
               element.fadeOut(2000, function(){
                  element.remove();
               });
            }, 2000)
         }
      }
   })
   /**
    * Display a vote counter for a particular post
    */
   .directive('countVotesFor', function(PostVote) {
      return {
         restrict: 'A',
         scope: {
            post: "=countVotesFor"
         },
         templateUrl: '/templates/widgets/votecounts.html',
         controller: function($scope) {
            $scope.votes = {}
            $scope.messages = []

            function recalculateVotes() {
               $scope.votes.total = $scope.post.post_votes.reduce(function(acc, i) {return acc + i.value}, 0)
               $scope.votes.up = $scope.post.post_votes.filter(function(i) {return i.value == 1}).length
               $scope.votes.down = $scope.post.post_votes.filter(function(i) {return i.value == -1}).length
            }

            function message(text) {
               $scope.messages.push({
                  shortDesc: text,
                  time: Date.now()
               });
            }

            function error(text, e) {
               $scope.messages.push({
                  shortDesc: text,
                  longDesc: e.data,
                  time: Date.now()
               });
               console.log("Vote error: ", text, e)
            }

            $scope.vote = function(value) {
               var vote = new PostVote({post_id: $scope.post.id, value: value});
               return vote.$save(null, function(){
                  // Remove any previous vote from this user
                  $scope.post.post_votes = $scope.post.post_votes.filter(function(oldVote){
                     return oldVote.user_id != vote.user_id
                  })

                  $scope.post.post_votes.push(vote)
                  message("Voted!")
               }, function(e) {
                  error(e.data.error || "Vote Failed.", e)
               });
            }

            $scope.$watch('post.post_votes', recalculateVotes, true)
         }
      }
   })
   /**
    * Elements with the class navbar-dynamic-top will have inline position until they
    * are scrolled out of view, at which point they have fixed position at the top of
    * the window.
    */
   .directive('navbarDynamicTop', function() {
      return {
         restrict: 'C',
         scope: false,
         compile: function(element, attrs) {
            var fixedClass = 'navbar-fixed-top';
            var placeholder = $('<div>');

            element
               .replaceWith(placeholder)
               .appendTo(placeholder);

            if (element.hasClass(fixedClass)) {
               console.log("Warning: navbar-dynamic-top should not be used on fixed position elements, but", element, "has class", fixedClass);
            }

            function updatePositioning() {
               // Check whether the element has been scrolled out of view
               if (placeholder.offset().top < $(window).scrollTop()) {
                  element.addClass(fixedClass);
               } else {
                  element.removeClass(fixedClass);
               }
            }

            function updatePlaceholder() {
               placeholder.height(element.height());
            }

            return function postLink(scope, element, attrs) {
               $(window)
                  .scroll(updatePositioning)
                  .resize(updatePlaceholder);

               element.on('$destroy', function() {
                  $(window)
                     .off('scroll', updatePositioning)
                     .off('resize', updatePlaceholder);
               })
            }
         }
      }
   })
