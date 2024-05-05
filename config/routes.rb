Rails.application.routes.draw do
 root to: "homes#top"
 devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

 resources :users, only: [:index, :show, :edit, :update, :create] do
  resources :books, only: [:create]
 end
 resources :books, only: [:create, :index, :show, :edit, :update, :destroy]

 get "/" => "homes#top"
 get "home/about" => "homes#about", as: "about"
end
