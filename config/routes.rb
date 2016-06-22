Rails.application.routes.draw do
  root 'pages#email'
  get 'menu' => 'pages#menu'
  get 'thank_you' => 'pages#thank_you'

  resource :users
  resources :votes, only: [:index, :create]
end
