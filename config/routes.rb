Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :users, only: %i[create update]
  get '/confirm_email/:id', to: 'sessions#confirm_email', as: 'confirm_email_user'
  get '/signup', to: 'users#new'
  get '/edit_user', to: 'users#edit'

  resources :sessions, only: %i[create]
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  # routes for bidding profile
  resources :bidding_profiles

  constraints FillBiddingProfileRouteConstraint.new do
    root 'bidding_profiles#new', as: 'new_bidding_profile_path'
  end

  constraints FreelancerRouteConstraint.new do
    root 'bidding_profiles#index', as: 'bidding_profiles_path'
  end

  constraints ClientRouteConstraint.new do
    root 'projects#index', as: 'projects_path'
  end
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

  # authenticated routes for projects and bidding profile

  # routes for conversations and messages
  resources :conversations, only: %i[index create] do
    resources :messages, only: %i[index create]
  end

  # route for a specific job and its categories
  resources :job_categories, only: [:show]

  # routes for bidding profile
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

  get 'users', to: redirect('/users/sign_up')
  # root path for unauthenticated users
  root 'pages#main'
end
