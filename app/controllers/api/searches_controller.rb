module Api
  class SearchesController < ApplicationController

  def index
  
        def search(name)
        client = Instagram.client
        result = client.user_search(name)
        return result
        end

        @result = search(params[:name])[0]
        render json: @result
  
  end

  end

end