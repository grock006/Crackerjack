var app = angular.module("myApp",['ngResource', 'ui.router', 'templates', 'uiGmapgoogle-maps', 'nprogress-rails', 'ngAutocomplete', 'angularSpinner']);

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
        templateUrl: 'about.html'
      })
      .state('contact', {
        url: '/contact',
        templateUrl: 'about.html'
      })
        .state('login', {
        url: '/login',
        templateUrl: 'about.html'
      })
        .state('signup', {
        url: '/signup',
        templateUrl: 'about.html'
      });
     
    $urlRouterProvider.otherwise('/');

  }]);


NProgress.configure({
  showSpinner: false,
  ease: 'ease',
  speed: 700
});



