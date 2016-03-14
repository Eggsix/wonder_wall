Rails.application.routes.draw do
	devise_for :users
	resources :pins do 
	    resources :comments, module: :pins
	end

	resources :users do 
		resources :comments, module: :users
	end

	
	get '/user/:id' => 'users#show'
	root 'pins#index'
	get 'about' => 'pages#about'
end
