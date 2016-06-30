Rails.application.routes.draw do
  root 'pages#home'
  get 'start' => 'pages#start'
  get 'menu' => 'pages#menu'
  get 'thank_you' => 'pages#thank_you'
  get 'results' => 'votes#index'
  get 'comments' => 'pages#comments'

  resource :users
  resources :votes, only: [:index, :create, :update]
end
