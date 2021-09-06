Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/admin' do
    resources :users_admin, :controller => 'users'
    resources :pending_brokers, only: [:index, :update]
  end
  get 'my_portfolio', to:'transactions#my_portfolio'
  get 'buyer_stock_market', to:'transactions#buyer_stock_market'
  get 'search_stock', to: 'stocks#search'
  get 'stocks/search'
  resources :stocks, only: [:show]
  resources :transactions, only: [:create,:new]
end
