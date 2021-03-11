RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  config.authorize_with do
    redirect_to main_app.root_path unless current_user.try(:admin?)
  end

  config.current_user_method(&:current_user)

  config.model 'User' do
    weight(-6)
    list do
      field :id
      field :name
      field :email
      field :role
      field :approved
      field :admin
    end
  end

  config.model 'Project' do
    weight(-5)
    list do
      field :id
      field :client do
        label 'Project posted_by'
      end
      field :title
      field :category
      field :subcategory
    end
  end
  config.model 'BiddingProfile' do
    weight(-4)
    list do
      field :id
      field :freelancer
      field :category
      field :subcategory
      field :experience
    end
  end

  config.model 'Bid' do
  
    parent 'Project'
    list do
      field :id
      field :freelancer
      field :value
      field :proposal
    end
  end

  config.model 'Message' do
    weight(-2)
    parent 'Conversation'
    list do
      field :id
      field :content
      field :user do
        label 'Message sent_by'
      end
    end
  end

  config.model 'Conversation' do
    list do
      field :id
      field :sender
      field :recipient
    end
  end

  config.model 'Notification' do
    visible false
  end

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
