Rails.application.routes.draw do
<<<<<<< Updated upstream
  devise_for :users
  resources :groups
  resources :groups_users
  resources :orders
  resources :friends
=======
  devise_for :users 
    resources :groups
    resources :groups_users
>>>>>>> Stashed changes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"


<<<<<<< Updated upstream
=======
  # get 'details' => 'meals#details'
  


>>>>>>> Stashed changes
  get '/orders/new' => 'orders#new'
  post '/orders' => 'orders#create', as: 'newOrder'

  #after submitting new order, redirect to its details page
  get '/orders/details/:id' => 'meals#details', as: 'details'
  post '/orders/details/:id' => 'meals#addMeal', as: 'addMeal'

  # After creating order, redirect to invite friends page
  get '/orders/invite/:id' => 'orders#inviteFriends', as: 'inviteFriends'
  post '/orders/invite/:id' => 'orders#invite', as: 'invite'
  delete '/orders/invite/:id' => 'orders#cancel', as: 'cancel'

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

end
