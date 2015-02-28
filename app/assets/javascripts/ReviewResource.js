app.factory("ReviewResource", function($resource) {

  return function(name, location){

  
  var Resource = $resource('/api/review/:id', {id: '@id'},
                    {
                      search: {
                            method: 'GET', isArray: true,
                            url: '/api/review/:id',
                            params:{name: name, location: location},
                            headers : {'Content-Type' : 'application/json'},
                          } 
                    });

   return Resource;

 }
  });