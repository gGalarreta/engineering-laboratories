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

  resources :profile

  resources :audits, only: [:index]

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

  resources :system_parameters

  resources :inventories

  resources :supplies

  resources :audits, only: [:index]

  resources :client_services do 
    get 'search', on: :collection
  end

  resources :employee_services do 
    get 'search', on: :collection
  end

  resources :client_quotations

  resources :employee_quotations do
    post 'get_sample_methods', on: :collection
    post 'get_sample_method', on: :collection
    get 'contract_pdf', on: :collection
  end

  resources :employee_custody_orders do 
    get 'values', on: :member
  end

  resources :supervisor_custody_orders do
    get 'custody_check', on: :member
    put 'custody_check_update', on: :member
  end

end
