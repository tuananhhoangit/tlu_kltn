Rails.application.routes.draw do
  root "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :users, only: [:index, :show]
  resources :posts, only: [:create, :update, :destroy] do
    resources :comments, only: [:create, :update, :destroy]
  end
end
