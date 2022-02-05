Rails.application.routes.draw do
  resources :line_items
  devise_for :users
  resources :users
  resources :items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
