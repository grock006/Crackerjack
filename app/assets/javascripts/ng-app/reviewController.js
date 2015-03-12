app.controller("reviewController",function($scope, $resource, Review){

    $scope.submitMessage = null

    Review.query(function(data){
    $scope.userReviews = data
  });

 $scope.createReview = function() {
    new Review(
      {
        name: $scope.newReview.name,
        title: $scope.newReview.title,
        content: $scope.newReview.content,
        score: $scope.newReview.score,
        restaurant: $scope.details.name
      }
    ).$save(function(data){
      console.log(data);
       $scope.userReviews.unshift(data);
       $scope.newReview = null;
       $scope.submitMessage = "Thanks For The Review, Crackerjacker!"
    });
  };
}); 
