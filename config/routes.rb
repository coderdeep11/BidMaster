Rails.application.routes.draw do
  get 'freelancer_infos/index'
  devise_for :users
  get 'pages/main', as: 'welcome'
  resources :freelancer_infos, only: %i[index create update edit]
  root 'pages#main'
end
