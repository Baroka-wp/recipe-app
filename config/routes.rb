Rails.application.routes.draw do
  devise_for :users
  
  root to: 'foods#index'
  resources :users
  resources :foods
  resources :recipes
  
end
