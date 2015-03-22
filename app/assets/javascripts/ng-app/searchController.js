app.controller("searchController",function($scope, ImageResource, ReviewResource, YelpResource, usSpinnerService){

    $scope.errorMessage = ""
    $scope.descriptionClass = "description";
    $scope.darkBackground = "dark-background";

    $scope.image = "instagram"

    $scope.makeLarge = function(url, text, username, userpic, link){
        $scope.main_image_url = url;
        $scope.imageText = text;
        $scope.userName = username;
        $scope.userPic = userpic;
        $scope.imageLink = link;
    }

  $scope.options1 = {
      types: 'establishment',
      watchEnter: false
    };

    $scope.details = ""

$scope.searchName = function(name, location){

    $scope.errorMessage = ""
    $scope.darkBackground = "darker-background";

    $scope.startSpin = function(name, location){
        usSpinnerService.spin('spinner-1');
    }

    $scope.stopSpin = function(){
        usSpinnerService.stop('spinner-1');
    }

    $scope.main_keywords = [];
    $scope.detailsName = $scope.details.name

    if($scope.detailsName){
        $scope.startSpin();
        $scope.descriptionClass = "describe-hidden";
        $scope.darkBackground = "darker-background";
    }
    else {
        $scope.errorMessage = "Please Enter Full Autocomplete Name and Address"
    }

    name = $scope.details.name
    location = $scope.details.address_components[2].long_name + " " + $scope.details.address_components[3].short_name
    $scope.google = $scope.details

    var images = ImageResource(name, location);

    $scope.imageresults = []
    $scope.imageresults = images.search();
    $scope.imageresults.$promise.then(function(data) {
    $scope.imageresults = data;
    $scope.main_image_url = data[0].images.low_resolution.url
    });

    var reviews = ReviewResource(name, location);

    $scope.reviewresults = []
    $scope.reviewresults = reviews.search();

    console.log($scope.reviewresults);
    
    $scope.reviewresults.$promise.then(function(data) {
        if (data){
            $scope.stopSpin();
            console.log("hello world");
        }
    console.log(data);
    console.log(data.$resolved);    
    $scope.reviewresults = data;  
    $scope.totalAverage = parseInt(data[0]['docSentiment']['totalAverage']);
    $scope.positiveReviews = parseInt(data[0]['docSentiment']['pos_total']);
    $scope.negativeReviews = parseInt(data[0]['docSentiment']['neg_total']);
    $scope.totalReviews = parseInt(data[0]['docSentiment']['total_review']);
    $scope.main_keywords = [data[0]['docSentiment']["keywords"][2].text, 
                            data[1]['docSentiment']["keywords"][2].text,
                            data[2]['docSentiment']["keywords"][2].text
                            ];
    $scope.rating = (($scope.positiveReviews / $scope.totalReviews) * 100) / 20    
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



   

