Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
  end
  root 'posts#index'
  get '/frontend', to: 'posts#frontend'
  get '/backend', to: 'posts#backend'
  get '/gamedev', to: 'posts#gamedev'
  get '/datascience', to: 'posts#datascience'
end
