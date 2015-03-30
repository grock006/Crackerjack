app.controller("authController",function($scope, $http, $rootScope){


    $scope.login = function() {
      $http.post('/api/login', {user: {username: $scope.username, password: $scope.password}}).success(function(data){
        
        if(data.error) {
          $('.error-flash').addClass('alert alert-danger').html('<span class="glyphicon glyphicon-exclamation-sign"></span> ' + data.error);
        } else {
          
          $http.get('/api/currentuser').success(function(data){
            if(data) {
              $rootScope.currentUser = data;
              loggedIn = true;
              $('#login').modal('hide');
              window.reload();
              }
            });
        }

      
      });
    
  };


}); 







