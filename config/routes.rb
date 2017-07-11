Rails.application.routes.draw do
  root "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end
  resources :posts, except: [:new, :show] do
    resources :comments
  end
  resources :relationships, except: [:index, :new, :show]
end
