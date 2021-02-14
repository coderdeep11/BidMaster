Rails.application.routes.draw do
  get 'messages/index'
  get 'conversations/index'
  devise_for :users

  resources :freelancer_infos, only: %i[index create update edit]
  resources :projects, only: %i[index create update edit show] do
    resources :bids,only: [:create,:index]
  end
  devise_scope :user do
    authenticated :user, ->(u) { u.try(:role) == 'client' } do
      root to: 'projects#index'
    end
    authenticated :user, ->(u) { u.try(:role) == 'freelancer' } do
      root to: 'freelancer_infos#index', as: :freelancer_infos_path
    end
  end
  resources :conversations, only: %i[index create] do
    resources :messages, only: %i[index create]
  end
  get 'dropdown/user-profile', to: 'dropdowns#user_profile', as: 'dropdown_profile'
  root 'pages#main', as: :visitors_url
end
