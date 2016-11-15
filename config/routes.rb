Rails.application.routes.draw do

  devise_for :users
  root 'restaurants#index'

  resources :restaurants do
    resources :reviews
  end

  # get '/restaurants/new' => 'restaurants#new'
  # post '/restaurants', to: 'restaurants#create'
  # get '/restaurants/:id' => 'restaurants#show', as: :restaurant
  # get 'restaurants/:id/edit' => 'restaurants#edit', as: :edit_destination

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
