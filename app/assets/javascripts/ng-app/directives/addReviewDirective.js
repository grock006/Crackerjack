app.directive("addReview", function(){
    return{
      restrict: 'A',
      templateUrl: 'add-review.html',
      controller: 'reviewController'
    };
  });