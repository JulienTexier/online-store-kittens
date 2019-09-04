Rails.application.routes.draw do
	root 'items#index'
  resources :join_items_orders
	resources :join_table_carts_items
  resources :carts, except: [:index, :new]
  resources :profile, only: [:show, :edit, :update] do 
    resources :orders
  end
  resources :items
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
