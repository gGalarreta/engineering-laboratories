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

  resources :roles
  resources :clients
  resources :employees
  resources :laboratories
end
