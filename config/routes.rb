Rails.application.routes.draw do
  
    root "application#index"

    namespace :api do
        get "/show" => "searches#show"
        get "/review" => "searches#review"
        get "/results" => "searches#yelp"
    end

    namespace :api do
    	resources :reviews
    	resources :restaurants
  	end

    namespace :api do
        # session routes for login and logout
        post '/login' => 'sessions#create'
        delete '/logout' => 'sessions#destroy'

        # user routes for sign up and to validate current user
        post '/signup' => 'users#create'
        get '/currentuser' => 'users#show'
    end

end
