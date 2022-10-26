Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users

  resources :categories do
    resources :tasks    # associates task to categories
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
