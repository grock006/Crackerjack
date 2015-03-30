app.factory("Restaurant", function($resource) {  
   return $resource('/api/restaurants/:id', {id:'@id'},
                      {
                        'update': {method: 'patch'}
                      })
});
