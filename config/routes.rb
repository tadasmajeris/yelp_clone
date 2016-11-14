Rails.application.routes.draw do
  get '/restaurants' => 'restaurants#index'
  get '/restaurants/new' => 'restaurants#new'
  post '/restaurants' => 'restaurants#create'
  get '/restaurants/:id' => 'restaurants#show', as: :restaurant

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
