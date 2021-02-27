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
      resources :details, only: [:index] do
        get :job_post, on: :collection
        get :review_proposals, on: :collection
        get :all_proposals, on: :collection
        get :shortlisted, on: :collection
        get :rejected, on: :collection
      end
    end
  end
  devise_scope :user do
    authenticated :user, ->(u) { u.try(:role) == 'client' } do
      root to: 'projects#index'
      get '/client/:id', to: 'profiles#view', as: 'client'
      get '/client/experience', to: 'profiles#experience', as: 'client_experience'
    end
    authenticated :user, ->(u) { u.try(:role) == 'freelancer' } do
      root to: 'freelancer_infos#index', as: :freelancer_infos_path
      get '/freelancer/experience', to: 'profiles#experience', as: 'freelancer_experience'
      get '/freelancer/about-me', to: 'profiles#about', as: 'freelancer_about-me'
      get '/freelancer/details', to: 'profiles#details', as: 'freelancer_details'

      get '/freelancer/:id', to: 'profiles#view', as: 'freelancer'
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
  get '/search/freelancer/:id/profile', to: 'pages#freelancer_profile', as: 'search_freelancer_profile'
  root 'pages#main', as: :visitors_url
end
