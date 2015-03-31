app.directive("newyorkRestaurants", function(){
    return{
      restrict: 'A',
      templateUrl: 'newyork-restaurants.html',
      controller: 'restaurantController'
    };
  });