Rails.application.routes.draw do
  
    root "application#index"

    namespace :api do
        get "/show" => "searches#show"
        get "/review" => "searches#review"
        get "/results" => "searches#yelp"
    end

    namespace :api do
    	resources :reviews
  	end

end
