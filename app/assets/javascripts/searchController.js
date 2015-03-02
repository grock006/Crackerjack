app.controller("searchController",function($scope, ImageResource, ReviewResource, YelpResource){

      $scope.movies = ["Lord of the Rings",
                        "Drive",
                        "Science of Sleep",
                        "Back to the Future",
                        "Oldboy"];

        // gives another movie array on change
        $scope.updateMovies = function(typed){
            // MovieRetriever could be some service returning a promise
            $scope.newmovies = MovieRetriever.getmovies(typed);


              var url = 'http://api.yelp.com/v2/search';
              var params = {
                                callback: 'angular.callbacks._0',
                                location: 'San+Francisc',
                                oauth_consumer_key: "Xnvaip0-eY6FzwXXgS-Ctw",
                                oauth_token: "bSIXuYiiYZWLx7cPiYfQQYB5LCP49ps8",
                                oauth_signature_method: "HMAC-SHA1",
                                oauth_timestamp: new Date().getTime(),
                                oauth_nonce: randomString(32, '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                                term: 'food'
                            };

              $http.get(url, {params: params}).success(function(data){
                    $scope.results = data;
                    console.log(data)
                  });

            $scope.newmovies.then(function(data){
              $scope.movies = data;
            });
        }


   $scope.searchName = function(name, location){

    var images = ImageResource(name, location);

    $scope.imageresults = []
    $scope.imageresults = images.search();
    $scope.imageresults.$promise.then(function(data) {
    $scope.imageresults = data;
    });

    var reviews = ReviewResource(name, location);

    $scope.reviewresults = []
    $scope.reviewresults = reviews.search();
    $scope.reviewresults.$promise.then(function(data) {
    $scope.reviewresults = data;  
    $scope.totalAverage = parseInt(data[0]['docSentiment']['totalAverage']);
    console.log(data)     
    });

    var yelp = YelpResource(name, location);

    $scope.yelpresults = []
    $scope.yelpresults = yelp.search();
    $scope.yelpresults.$promise.then(function(data) {
    $scope.yelpresults = data;
    var latitude = data[0]["hash"].location.coordinate.latitude
    var longitude = data[0]["hash"].location.coordinate.longitude
    $scope.map = { center: 
      { latitude: latitude, 
        longitude: longitude }, 
        zoom: 16 };
     $scope.marker = { 
                id: 1,
                coords: {
                latitude: latitude, 
                longitude: longitude
                }
       }
    
    });

 };
   

});

    // $scope.map.center = {
    //     latitude: position.coords.latitude,
    //     longitude: position.coords.longitude
    //   };


   

