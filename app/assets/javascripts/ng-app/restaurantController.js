app.controller("restaurantController",function($scope, $resource, Restaurant){

    Restaurant.query(function(data){
    $scope.restaurants = data

  });


}); 
