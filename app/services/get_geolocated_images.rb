class GetGeolocatedImages
      
      @yelp = Yelp.client
      @client = Instagram.client

    def self.call(name, location)
        @results = @yelp.search( location, { term: name, limit: 3 })
        # get the latitude and longitude coordinates and pass them into Instagram location search
        lat = @results.businesses[0].location.coordinate.latitude
        lng = @results.businesses[0].location.coordinate.longitude

        # get the instagram images based on latitude and longitude from the Yelp API call
        images = @client.media_search(lat, lng, distance: 1)

        if images == true
           @images = @client.media_search(lat, lng, distance: 5).take(10)
        else
           @images = @client.media_search(lat, lng, distance: 10).take(10)
        end

        return @images 

    end


end




