Rails.application.routes.draw do
  
    root "application#index"

    namespace :api do
        get "/searches" => "searches#index"
    end
end
