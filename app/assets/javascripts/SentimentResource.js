app.factory("SentimentResource", function($resource) {

  return function(name){

  
  var Resource = $resource('/api/sentiment/:id', {id: '@id'},
                    {
                      search: {
                            method: 'GET', isArray: true,
                            url: '/api/sentiment/:id',
                            params:{name: name},
                            headers : {'Content-Type' : 'application/json'},
                          } 
                    });

   return Resource;

 }
  });