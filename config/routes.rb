Rails.application.routes.draw do

 devise_for :users

 root to: "homes#top"
 get 'homes/about', to: 'homes#about', as: 'about'

 resources :users, only: [:edit, :show, :update]
 resources :books, only: [:edit, :create, :index, :show]

end
