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
        templateUrl: 'index.html'
      })
      .state('about', {
        url: '/about',
        templateUrl: 'about.html'
      });
     
    $urlRouterProvider.otherwise('/');

  }]);


NProgress.configure({
  showSpinner: false,
  ease: 'ease',
  speed: 700
});



