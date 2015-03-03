app.factory("Review", function($resource) {  
   return $resource('/api/reviews/:id', null,
                      {
                        'update': {method: 'PUT'}
                      })
           });
