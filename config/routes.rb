Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friends', to: 'users#search'
  post 'add_friend', to: 'users#add_friend'
  post 'user_stock_daily_change', to: 'user_stocks#daily_change'

  resources :user_stocks, only: [:create, :destroy, :daily_change]
  resources :users, only: [:show]
  resources :friendships
end
