app.factory("YelpResource", function($resource) {

  return function(name, location){

  
  var Resource = $resource('/api/results/:id', {id: '@id'},
                    {
                      search: {
                            method: 'GET', isArray: true,
                            url: '/api/results/:id',
                            params:{name: name, location:location},
                            headers : {'Content-Type' : 'application/json'},
                          } 
                    });

   return Resource;

 }
  });