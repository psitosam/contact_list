Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # get '/contacts', to: 'contacts#index'
      # get '/contacts/:id', to: 'contacts#show'
      # post '/contacts/', to: 'contacts#create'
      # put '/contacts/:id', to: 'contacts#update'
      resources :contacts do
        resources :phones
      end 
    end
  end
end
