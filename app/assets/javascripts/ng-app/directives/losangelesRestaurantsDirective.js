app.directive("losangelesRestaurants", function(){
    return{
      restrict: 'A',
      templateUrl: 'losangeles-restaurants.html',
      controller: 'restaurantController'
    };
  });