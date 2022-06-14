Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
  end
  root 'posts#index'
  get '/posts/frontend', to: 'posts#frontend'
  get '/posts/backend', to: 'posts#backend'
  get '/posts/gamedev', to: 'posts#gamedev'
  get '/posts/datascience', to: 'posts#datascience'
end
