app.controller("reviewController",function($scope, $resource, Review){

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
        restaurant: $scope.newReview.restaurant
      }
    ).$save(function(data){
      console.log(data);
       $scope.newReview = null
    });
  };
}); 


 // $scope.createPost = function() {
 //    new Post({
 //      title: $scope.newPost.title,
 //      link: $scope.newPost.link
 //    }).$save(function(data){
 //      $scope.posts.unshift(data);
 //      $scope.newPost = null
 //    });
 //  }