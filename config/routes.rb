Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"
  resource :friends
  get 'details/:id' => 'meals#details'
  post 'details/:id' => 'meals#addMeal', as: 'addMeal'
end
