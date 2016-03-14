Rails.application.routes.draw do
  resources :pins
  devise_for :users
  get '/users/:id' => 'users#show'
  root 'pins#index'
  get 'about' => 'pages#about'
end
