Rails.application.routes.draw do
  devise_for :users

  root to: 'foods#index'
  resources :users, except: :show
  resources :foods, except: :show
  resources :recipes, except: :show

end
