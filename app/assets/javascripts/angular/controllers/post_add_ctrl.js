function PostAddCtrl($scope, Post, $state) {
    var state = $state;
    $scope.moreInfoCollapsed = true;
    $scope.titleValidate = false;
    $scope.contentValidate = false;
    $scope.errorValidate = false;
    $scope.modelSaveValidate = false;

    $scope.moreInfo =	"The goal of these posts is to impart experiential knowledge to others about computer science as a "+
						"field of study and a profession.  The wisdom gathered here is intended to capture knowledge and "+
						"understanding that comes from lessons learned, personal stories and experiences, or observations.  "+
						"Browse existing posts for examples.";
    /*
    t.integer  "user_id"
    t.datetime "created_on"
    t.text     "content"
    t.string   "title"
	*/
	function redirectHome(flash) {
		state.go('index', {addsuccess: flash});
	}
	$scope.save = function(post, $state) {
        // Fields are required
        if(!post.title) {
			$scope.titleValidate = true;
			$scope.contentValidate = false;
			$scope.errorValidate = true;
			return;
		}
		else if(!post.content) {
			$scope.contentValidate = true;
			$scope.titleValidate = false;
			$scope.errorValidate = true;
			return;
		}
		else {
			$scope.titleValidate = false;
			$scope.contentValidate = false;
		    $scope.errorValidate = false;
		}

		// persist the post
		var datetime = currentdate.getFullYear() + "-"
				+ (currentdate.getMonth()+1) + "-"
				+ currentdate.getDate() + " ["
                + currentdate.getHours() + ":"
                + currentdate.getMinutes() + ":"
                + currentdate.getSeconds()+"]";

        var newpost = new Post({title:post.title, content:post.content});
		newpost.$save(function(response, $state, $scope) {
 			// Saving to the database on the model side was successful.  Redirect and create flash message in post index view.
 			if(response.success) {
	 			redirectHome(response.success);
			}
			// Unsuccessful.  Show flash error and do NOT redirect.
			else {
				$scope.modelSaveValidate = true;
			}

        }, function(response) {
            //Post response objects to the view
            $scope.errors = response.data.errors;
            Logger.log($scope.errors);
        });
    }

}
PostAddCtrl.$inject = ['$scope', 'Post', '$state'];

