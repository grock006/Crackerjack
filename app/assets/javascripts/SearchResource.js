app.factory("SearchResource", function($resource) {

  return function(name){

  
  var Resource = $resource('/api/searches/:id', {id: '@id'},
                    {
                      search: {
                            method: 'GET',
                            url: '/api/searches/:id',
                            params:{name: name},
                            headers : {'Content-Type' : 'application/json'},
                          } 
                    });

   return Resource;

 }
  });
