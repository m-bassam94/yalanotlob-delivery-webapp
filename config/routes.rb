Rails.application.routes.draw do
  devise_for :users 
    resources :groups
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  get '/orders/new' => 'orders#new'
  post '/orders' => 'orders#create', as: 'newOrder'

  #after submitting new order, redirect to its details page
  get '/orders/details/:id' => 'meals#details', as: 'details'
  post '/orders/details/:id' => 'meals#addMeal', as: 'addMeal'
  resource :friends
  resource :users

end
