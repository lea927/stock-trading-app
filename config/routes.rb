Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/admin' do
    resources :users_admin, :controller => 'users'
    resources :brokers, only: [:index,:update]
  end
  get 'my_portfolio', to:'transactions#my_portfolio'
end
