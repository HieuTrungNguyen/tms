Rails.application.routes.draw do
  root "static_pages#index"

  get "/signup",    to: "users#new"
  post "/signup",   to: "users#create"
  get "/login",     to: "sessions#new"
  post "/login",    to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :trainee do
    resources :users do
      member do
        get :show_profile
      end
    end
  end

  resources :users do
    member do
      get :show_profile
    end
  end

  resources :courses do
    member do
      get :edit_profile
      get :member_remaining
    end
    collection do
      get :add_member
    end
  end

  resources :subjects
end
