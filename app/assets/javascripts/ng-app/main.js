var app = angular.module("myApp",['ngResource', 'uiGmapgoogle-maps', 'nprogress-rails', 'ngAutocomplete', 'angularSpinner']);

//configuration 
app.config(['$httpProvider',
    function ($httpProvider) {
      // send security token to rails with every angular http request
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);  // .config


NProgress.configure({
  showSpinner: false,
  ease: 'ease',
  speed: 700
});

