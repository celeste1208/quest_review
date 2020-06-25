Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :users
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  
  resources :users, only: [:show, :update, :update_icon]
  resources :quests
  resources :comments, only: [:create, :update, :destroy]
end
