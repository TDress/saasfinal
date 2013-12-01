angular.module('saasfinal', ['ui.router', 'ui.bootstrap', 'ngResource', 'saasfinal.cookies', 'saasfinal.post', 'saasfinal.toolbar'])
   .config(function($stateProvider, $urlRouterProvider, $httpProvider, $locationProvider){
      $urlRouterProvider.otherwise("/");
      $stateProvider.
         state('index', {
            url: "/?addsuccess",
            templateUrl: "/templates/posts/index.html",
            controller: PostIndexCtrl
         }).
         state('addPost', {
            url: "/add-post",
            templateUrl: "/templates/posts/add-post.html",
            controller: PostAddCtrl
         });
   })
