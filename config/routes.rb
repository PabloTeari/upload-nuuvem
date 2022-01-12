Rails.application.routes.draw do
  get 'docs/index'
  get 'docs/new'
  get 'docs/create'
  get 'docs/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :docs, only: [:index, :new, :create, :destroy]
   root "docs#index"
end

