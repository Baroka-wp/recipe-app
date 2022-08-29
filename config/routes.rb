Rails.application.routes.draw do
  devise_for :users
  
  root to: 'recipes#public'
  get '/public_recipes', to: 'recipes#public', as: :public_recipes
  resources :users
  resources :foods, except: [:update]

  resources :recipes, except: [:update] do
    resources :recipe_foods, only: [:create, :new, :edit, :update, :destroy]
  end

end
