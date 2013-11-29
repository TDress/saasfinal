function PostAddCtrl($scope, Post, $location) {
    $scope.moreInfoCollapsed = true;
    $scope.titleValidate = false;
    $scope.contentValidate = false;
    $scope.errorValidate = false;
    
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
	$scope.save = function(post, $location) {
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
		// To test, hardcode in the user as John P, user_id = 0
		var user_id = 0;
		var currentdate = new Date(); 
		var datetime = currentdate.getFullYear() + "-"
				+ (currentdate.getMonth()+1) + "-"
				+ currentdate.getDate() + " ["
                + currentdate.getHours() + ":"  
                + currentdate.getMinutes() + ":" 
                + currentdate.getSeconds()+"]";
                
        var newpost = new Post({title:post.title, content:post.content, user_id:user_id, created_on:datetime});
		newpost.$save(function(response, $location) {
 
            //Redirect us back to the main page
            $location.path("/index")
 
        }, function(response) {
 
            //Post response objects to the view
            $scope.errors = response.data.errors;
            Logger.log($scope.errors);
        });
    }
    
}
PostAddCtrl.$inject = ['$scope', 'Post', '$location'];

