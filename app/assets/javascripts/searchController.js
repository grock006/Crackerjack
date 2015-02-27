app.controller("searchController",function($scope, SearchResource, ImageResource, ReviewResource, YelpResource){

  var num = [1, 2, 3];
  var total = 0;

 $scope.testSentiment = function(){
      for(var i = 0; i < num.length; i++){
         total += num[i]
         console.log(total);
         $scope.total = total
      }
    };

  //Show all the User's Itineraries 
   $scope.searchName = function(name, location){
  
    var settings = SearchResource(name);

    $scope.results = settings.search(); 
    $scope.results.$promise.then(function(data) {
    $scope.collection = data;
    });

    var images = ImageResource(name, location);

    $scope.imageresults = []
    $scope.imageresults = images.search();
    $scope.imageresults.$promise.then(function(data) {
    $scope.imageresults = data;
    });

    var reviews = ReviewResource(name);

    $scope.reviewresults = []
    $scope.reviewresults = reviews.search();
    $scope.reviewresults.$promise.then(function(data) {
    $scope.reviewresults = data;  
    $scope.totalAverage = data[0]['docSentiment']['totalAverage']
    console.log(data)     
    });

    var yelp = YelpResource(name, location);

    $scope.yelpresults = []
    $scope.yelpresults = yelp.search();
    $scope.yelpresults.$promise.then(function(data) {
    $scope.yelpresults = data;
    });
    
 };
   

});

    // var sentiments = SentimentResource(name);

    // $scope.sentimentresults = []
    // $scope.sentimentresults = sentiments.search();
    // $scope.sentimentresults.$promise.then(function(data) {
    // $scope.sentimentresults = data;
    // });

    // data[0]['docSentiment']['score'] + data[1]['docSentiment']['score']

  // $scope.totalSentiment = function(){
  //       for(var i = 0; i < reviewresults.length; i++)
  //           $scope.averageSentiment = data[i]['docSentiment']['score']++
  //   }