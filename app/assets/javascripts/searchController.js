app.controller("searchController",function($scope, ImageResource, ReviewResource, YelpResource){

  
    $scope.image = "instagram"

    $scope.makeLarge = function(idx){
        $scope.image.idx = "highlight"
    }

    $scope.makeSmall = function(idx){
        $scope.image.idx = "instagram"
    }

  $scope.options1 = {
      types: 'establishment'
    };

     $scope.options2 = {
      country: 'usa',
      types: '(cities)'
    };

    $scope.details = ""

   $scope.searchName = function(name, location){

    name = $scope.details.name
    location = $scope.details.address_components[2].long_name + " " + $scope.details.address_components[3].short_name
    $scope.google = $scope.details

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
    $scope.positiveReviews = parseInt(data[0]['docSentiment']['pos_total']);
    $scope.negativeReviews = parseInt(data[0]['docSentiment']['neg_total']);
    $scope.totalReviews = parseInt(data[0]['docSentiment']['total_review']);
    $scope.rating = (($scope.positiveReviews / $scope.totalReviews) * 100) / 20
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


   

