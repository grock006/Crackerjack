app.controller("restaurantController",function($scope, $resource, Restaurant){

    Restaurant.query(function(data){
    $scope.restaurants = data

    // $scope.positiveReviews = parseInt(data['positive_reviews']);
    // $scope.negativeReviews = parseInt(data['negative_reviews']);
    // $scope.totalReviews = parseInt(data['total_reviews']);
    // $scope.rating = (($scope.positiveReviews / $scope.totalReviews) * 100) / 20

  });


}); 
