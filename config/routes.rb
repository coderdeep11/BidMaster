Rails.application.routes.draw do
  get 'job_categories/index'
  get 'notifications/index'
  get 'messages/index'
  get 'conversations/index'
  devise_for :users

  resources :freelancer_infos, only: %i[index create]
  resources :projects, only: %i[index create update edit show] do
    scope module: 'projects' do
      resources :bids, only: %i[create update] do
        member do
          put :accept, to: 'bids#accept'
          put :reject, to: 'bids#reject'
          put :award, to: 'bids#award'
        end
      end
      get 'bid_history', to: 'bids#history', on: :collection
      resources :details, only: [:index]
    end
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

  resources :job_categories, only: [:show]

  get 'dropdown/user-profile', to: 'dropdowns#user_profile', as: 'dropdown_profile'
  get '/notifications', to: 'notifications#index', as: 'notifications'
  get '/search', to: 'pages#search', as: 'search_results'
  get '/choice', to: 'dropdowns#search_choice', as: 'search_choice'
  get '/search/freelancers', to: 'dropdowns#freelancer', as: 'search_freelancers'
  get '/search/projects', to: 'dropdowns#project', as: 'search_projects'
  root 'pages#main', as: :visitors_url
end
