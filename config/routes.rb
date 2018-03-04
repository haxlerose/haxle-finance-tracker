Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friends', to: 'users#search'
  post 'add_friend', to: 'users#add_friend'
  get 'daily_stock_change', to: 'users#daily_change'

  resources :user_stocks, only: [:create, :destroy]
  resources :users, only: [:show, :daily_change]
  resources :friendships
end
