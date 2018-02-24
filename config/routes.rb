Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
    devise_scope :user do
    get "signup", to: "devise/registrations#new"
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
    authenticated :user do
      root "dashboard#home"
    end

    unauthenticated do
      root 'devise/sessions#new'
    end
  end

  resources :roles do
    put "toggle_status", on: :member
  end
  resources :clients do 
    put "toggle_status", on: :member
  end
  resources :employees do
    put "toggle_status", on: :member
  end
  resources :laboratories do 
    put "toggle_status", on: :member
  end
  resources :sample_methods do 
    put "toggle_status", on: :member
  end

  resources :sample_categories do
    put "toggle_status", on: :member
  end

    resources :system_parameters do
    put "toggle_status", on: :member
  end

  resources :audits, only: [:index]
end
