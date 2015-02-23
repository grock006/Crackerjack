app.factory("ReviewResource", function($resource) {

  return function(name){

  
  var Resource = $resource('/api/review/:id', {id: '@id'},
                    {
                      search: {
                            method: 'GET', isArray: true,
                            url: '/api/review/:id',
                            params:{name: name},
                            headers : {'Content-Type' : 'application/json'},
                          } 
                    });

   return Resource;

 }
  });