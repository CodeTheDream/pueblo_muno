Rails.application.routes.draw do
  root 'pages#home'
  get 'start' => 'pages#start'
  get 'menu' => 'pages#menu'
  get 'thank_you' => 'pages#thank_you'
  get 'results' => 'votes#index'

  resource :users
  resources :votes, only: [:index, :create]
end
