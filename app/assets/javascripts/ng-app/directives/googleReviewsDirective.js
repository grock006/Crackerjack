app.directive("googleReviews", function(){
    return{
      restrict: 'A',
      templateUrl: 'google-reviews.html',
      controller: 'searchController'
    };
  });