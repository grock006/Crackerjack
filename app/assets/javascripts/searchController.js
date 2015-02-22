app.controller("searchController",function($scope, SearchResource){

  //Show all the User's Itineraries 
   $scope.searchName = function(name){
  
    var settings = SearchResource(name);

    $scope.results = settings.search(); 
    
    $scope.results.$promise.then(function(data) {
    $scope.collection = data;
    });

 };

     

});
