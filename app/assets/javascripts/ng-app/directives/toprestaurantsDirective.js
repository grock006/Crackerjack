app.directive("topRestaurants", function(){
    return{
      restrict: 'A',
      templateUrl: 'top-restaurants.html',
      controller: 'searchController'
    };
  });