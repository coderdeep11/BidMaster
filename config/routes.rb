Rails.application.routes.draw do
  devise_for :users

  resources :freelancer_infos, only: %i[index create update edit]
  resources :projects, only: %i[index create update edit]
  devise_scope :user do
    authenticated :user, ->(u) { u.try(:role) == 'client' } do
      root to: 'projects#index'
    end
    authenticated :user, ->(u) { u.try(:role) == 'freelancer' } do
      root to: 'freelancer_infos#index', as: :freelancer_infos_path
    end
  end

  root 'pages#main', as: :visitors_url
end
