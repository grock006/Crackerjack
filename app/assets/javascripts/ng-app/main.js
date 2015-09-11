var app = angular.module("myApp",
                        [ 'ngResource', 
                          'ui.router', 
                          'templates', 
                          'uiGmapgoogle-maps', 
                          'nprogress-rails', 
                          'ngAutocomplete', 
                          'angularSpinner', 
                          'ui.bootstrap']);

//configuration 
app.config(['$httpProvider',
    function ($httpProvider) {
      // send security token to rails with every angular http request
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);  

app.config(['$stateProvider', '$urlRouterProvider', 
 	function($stateProvider, $urlRouterProvider) {

    $stateProvider
      .state('index', {
        url: '/',
        templateUrl: 'index.html',
        controller: 'searchController'
      })
      .state('search', {
        url: '/search',
        templateUrl: 'search.html',
        controller: 'searchController'
      })
      .state('about', {
        url: '/about',
        templateUrl: 'about.html',
        controller: 'searchController'
      })
      .state('contact', {
        url: '/contact',
        templateUrl: 'contact.html',
        controller: 'searchController'
      })
        .state('login', {
        url: '/login',
        templateUrl: 'login.html',
        controller: 'authController'
      })
        .state('signup', {
        url: '/signup',
        templateUrl: 'signup.html',
        controller: 'signupController'
      });
     
    $urlRouterProvider.otherwise('/');

  }]);


NProgress.configure({
  showSpinner: false,
  ease: 'ease',
  speed: 700
});



