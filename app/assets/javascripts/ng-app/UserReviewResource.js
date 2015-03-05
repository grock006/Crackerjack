app.factory("Review", function($resource) {  
   return $resource('/api/reviews/:id', {id:'@id'},
                      {
                        'update': {method: 'patch'}
                      })
});
