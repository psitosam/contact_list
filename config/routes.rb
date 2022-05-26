Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/contacts', to: 'contacts#index'
      get '/contacts/call-list', to: 'contacts#call_list'
      get '/contacts/:id', to: 'contacts#show'
      post '/contacts/', to: 'contacts#create'
      put '/contacts/:id', to: 'contacts#update'
      delete '/contacts/:id', to: 'contacts#delete'
    end
  end
end
