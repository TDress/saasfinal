angular.module('saasfinal', ['ui.router', 'ui.bootstrap', 'ngResource', 'saasfinal.cookies', 'saasfinal.post'])
   .config(function($stateProvider, $urlRouterProvider, $httpProvider){
      $urlRouterProvider.otherwise("/");
      $stateProvider
         .state('index', {
            url: "/",
            templateUrl: "/templates/posts/index.html",
            controller: PostIndexCtrl
         });
   })
