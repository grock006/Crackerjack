app.controller("signupController",function($scope, $http, $rootScope){

  
    $scope.user = {
      username: null,
      email: null,
      password: null,
      password_confirmation: null
    };

 
    $scope.signup = function() {
      $http.post('api/signup', {user: $scope.user}).success(function(data) {
        
        if(data.errors) {
          $scope.errors = data.errors;
        } else {
          loggedIn = true;
          $http.get('/api/currentuser').success(function(data){
            if(data) {
              $rootScope.currentUser = data;
              $('.signup-create').hide().html("<div class='alert alert-success'>Account creation successful!</div>").fadeIn();
            }
          });
        }
      
      });
    };



}); 
