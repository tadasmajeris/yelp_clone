Rails.application.routes.draw do
  resources :restaurants

  # get '/restaurants' => 'restaurants#index'
  # get '/restaurants/new' => 'restaurants#new'
  # post '/restaurants' => 'restaurants#create'
  # get '/restaurants/:id' => 'restaurants#show', as: :restaurant
  # get 'restaurants/:id/edit' => 'restaurants#edit', as: :edit_destination

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
