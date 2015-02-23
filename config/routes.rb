Rails.application.routes.draw do
  
    root "application#index"

    namespace :api do
        get "/searches" => "searches#index"
        get "/show" => "searches#show"
        get "/review" => "searches#review"
    end
end
