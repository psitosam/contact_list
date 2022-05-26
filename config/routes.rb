Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/contacts', to: 'contacts#index'
      get '/contacts/call-list', to: 'contacts#call_list'
      get '/contacts/:id', to: 'contacts#show'
      post '/contacts/', to: 'contacts#create'
      put '/contacts/:id', to: 'contacts#update'
      delete '/contacts/:id', to: 'contacts#delete'

      # resources :contacts do
      #   resources :phones
      # end
    end
  end
end
