Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # routes for freelancers info
  resources :freelancer_infos, except: %i[show]

  # routes for projects
  resources :projects do
    get :more_info, on: :member
    scope module: 'projects' do
      resources :bids, only: %i[create update destroy] do
        member do
          put :accept, to: 'bids#accept'
          put :reject, to: 'bids#reject'
          put :award, to: 'bids#award'
        end
      end
      get 'bid_history', to: 'bids#history', on: :collection
      resources :details, only: [:index] do
        get :job_post, on: :collection
        get :review_proposals, on: :collection
        get :all_proposals, on: :collection
        get :shortlisted, on: :collection
        get :rejected, on: :collection
      end
    end
  end

  # authenticated routes for projects and freelancers info
  devise_scope :user do
    authenticated :user, ->(u) { u.try(:admin?) } do
      root to: 'rails_admin/main#dashboard', as: :admin_root
    end
    authenticated :user, ->(u) { u.try(:role) == 'client' } do
      root to: 'projects#index'
    end
    authenticated :user, ->(u) { u.try(:role) == 'freelancer' } do
      root to: 'freelancer_infos#index', as: :freelancer_infos_path
    end
  end

  # routes for conversations and messages
  resources :conversations, only: %i[index create] do
    resources :messages, only: %i[index create]
  end

  # route for a specific job and its categories
  resources :job_categories, only: [:show]

  # routes for freelancers info
  get '/freelancer/:id/experience', to: 'profiles#experience', as: 'freelancer_experience'
  get '/freelancer/:id/about-me/', to: 'profiles#about', as: 'freelancer_about-me'
  get '/freelancer/:id/details/', to: 'profiles#details', as: 'freelancer_details'
  get '/freelancer/:id', to: 'profiles#view_freelancer', as: 'freelancer'
  get '/client/:id/experience', to: 'profiles#experience', as: 'client_experience'
  get '/client/:id', to: 'profiles#view_client', as: 'client'
  # routes  for dropdowns
  get 'dropdown/user-profile', to: 'dropdowns#user_profile', as: 'dropdown_profile'
  get '/choice', to: 'dropdowns#search_choice', as: 'search_choice'
  get '/search/freelancers', to: 'dropdowns#freelancer', as: 'search_freelancers'
  get '/search/projects', to: 'dropdowns#project', as: 'search_projects'

  # routes for notifications
  get '/notifications', to: 'notifications#index', as: 'notifications'

  # routes regarding search
  get '/search', to: 'pages#search', as: 'search_results'
  get '/search/freelancer/:id/profile', to: 'pages#freelancer_profile', as: 'search_freelancer_profile'

  # root path for unauthenticated users
  root 'pages#main', as: :visitors_url
end
