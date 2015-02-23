app.factory("ImageResource", function($resource) {

  return function(name){

  
  var Resource = $resource('/api/show/:id', {id: '@id'},
                    {
                      search: {
                            method: 'GET', isArray: true,
                            url: '/api/show/:id',
                            params:{name: name},
                            headers : {'Content-Type' : 'application/json'},
                          } 
                    });

   return Resource;

 }
  });