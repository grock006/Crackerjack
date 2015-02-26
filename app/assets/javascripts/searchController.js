app.controller("searchController",function($scope, SearchResource, ImageResource, ReviewResource, SentimentResource){

  //Show all the User's Itineraries 
   $scope.searchName = function(name){
  
    var settings = SearchResource(name);

    $scope.results = settings.search(); 
    $scope.results.$promise.then(function(data) {
    $scope.collection = data;
    });

    var images = ImageResource(name);

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

    $scope.totalSentiment = function(){
        for(var i = 0; i < reviewresults.length;i++)
            $scope.averageSentiment = data[i]['docSentiment']['score']++
    }
    
    });

    var sentiments = SentimentResource(name);

    $scope.sentimentresults = []
    $scope.sentimentresults = sentiments.search();
    $scope.sentimentresults.$promise.then(function(data) {
    $scope.sentimentresults = data;
    });

 };
   

});

