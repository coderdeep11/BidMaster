module Admin
    class ProjectsController < ApplicationController
        before_action :authorized_only_to_admin!
      def index
        @projects=Project.all.order("created_at DESC")
       end
  
      def edit; end
  
      def update; end
  
      def show; end
  
      def destory; end
    end
  end
  