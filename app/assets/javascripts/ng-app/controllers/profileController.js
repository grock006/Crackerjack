app.controller("profileController",function($scope, $http, $rootScope){

   $http.get('/api/currentuser').success(function(data){
      if(data) {
        $scope.currentUser = data;
      }
    });

    $scope.logout = function() {
        $http.delete('/api/logout').success(function(){
        $rootScope.currentUser = null;
        loggedIn = false;
        window.reload();
      });
    };


}); 