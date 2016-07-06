Rails.application.routes.draw do
  root 'pages#home'
  get 'start' => 'pages#start'
  get 'menu' => 'pages#menu'
  get 'comments' => 'pages#comments'
  get 'thank_you' => 'pages#thank_you'
  get 'results' => 'pages#results'
  get 'voters' => 'pages#voters'

  resource :users
  resources :votes, only: [:index, :create, :update]
end
