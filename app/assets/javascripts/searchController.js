app.controller("searchController",function($scope, ImageResource, ReviewResource, YelpResource){

  var num = [1, 2, 3];
  var total = 0;

 $scope.testSentiment = function(){
      for(var i = 0; i < num.length; i++){
         total += num[i]
         console.log(total);
         $scope.total = total
      }
    };

    // $scope.map = { center: { latitude: 45, longitude: -73 }, zoom: 8 };

  //Show all the User's Itineraries 
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
    $scope.totalAverage = data[0]['docSentiment']['totalAverage']
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


   

