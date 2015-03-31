app.directive("sanfranciscoRestaurants", function(){
    return{
      restrict: 'A',
      templateUrl: 'sanfrancisco-restaurants.html',
      controller: 'restaurantController'
    };
  });