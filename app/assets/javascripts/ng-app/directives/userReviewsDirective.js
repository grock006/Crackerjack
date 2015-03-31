app.directive("userReviews", function(){
    return{
      restrict: 'A',
      templateUrl: 'user-reviews.html',
      controller: 'reviewController'
    };
  });