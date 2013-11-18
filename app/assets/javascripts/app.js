angular.module('saasfinal', ['ui.router', 'ngResource', 'saasfinal.post'])
   .config(function($stateProvider, $urlRouterProvider){
      $urlRouterProvider.otherwise("/");
      $stateProvider
         .state('index', {
            url: "/",
            templateUrl: "/templates/posts/index.html",
            controller: PostIndexCtrl
         });
   })
