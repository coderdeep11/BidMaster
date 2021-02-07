Rails.application.routes.draw do
  devise_for :users
  get 'pages/main', as: 'welcome'
  root 'pages#main'
end
