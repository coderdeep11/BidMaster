Rails.application.routes.draw do
  get 'notifications/index'
  get 'messages/index'
  get 'conversations/index'
  devise_for :users

  resources :freelancer_infos, only: %i[index create]
  resources :projects, only: %i[index create update edit show] do
    resources :bids, only: %i[create update]
    get 'bid_history', to: 'bids#bid_history', on: :collection
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
  get '/notifications', to: 'notifications#index', as: 'notifications'
  root 'pages#main', as: :visitors_url
end
