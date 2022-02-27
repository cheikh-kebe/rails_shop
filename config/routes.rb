Rails.application.routes.draw do
  
  namespace :purchase do
    resources :checkout, only: [:create, :success]
  end
  root "static_pages#home"
  get 'avatar/create'
  
  post "line_items/:id/add" => "line_items#add_quantity", as: "line_item_add"
  post "line_items/:id/reduce" => "line_items#reduce_quantity", as: "line_item_reduce"
  
  resources :orders, only: [:new, :create]

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users , :path => "utilisateur" do 
    resources :carts, :path => "panier"
    resources :avatars, only: [:create]
  end
  
  resources :items, only: [:show, :index]

  resources :line_items
  resources :static_pages, only: [:home]
end
