Rails.application.routes.draw do
  root "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :users, only: [:index, :show, :destroy] do
    member do
      get :following, :followers
    end
  end
  resources :posts, except: [:index, :new] do
    resources :comments
  end
  resources :relationships, except: [:index, :new, :show]
  namespace :admin do
    root "admins#index", as: :root
    resources :posts, only: [:index, :destroy]
  end
end
