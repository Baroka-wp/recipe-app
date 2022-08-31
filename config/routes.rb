Rails.application.routes.draw do
  devise_for :users
  
  root to: 'recipes#public'
  get '/public_recipes', to: 'recipes#public', as: :public_recipes
  get '/shoppingList_list/:recipe_id', to: 'recipe_foods#shoppingList', as: :shoppingList_list
  patch '/recipes/:id', to: 'recipes#mark_as_public', as: :update_recipe
  resources :users
  resources :foods, except: [:update]

  resources :recipes do
    resources :recipe_foods, only: [:create, :new, :edit, :update, :destroy]
  end

end