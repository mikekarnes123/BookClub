Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only: [:index, :show, :new, :create, :destroy] do
    resources :reviews, only: [:new, :create]
  end
  resources :authors, only: [:show, :destroy]
  root 'welcome#index'

  get "/users/:user_name", to: 'users#show', as: :user

  resources :reviews, only: [:destroy]
end
