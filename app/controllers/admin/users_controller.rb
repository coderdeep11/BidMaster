module Admin
  class UsersController < ApplicationController
    before_action :authorized_only_to_admin!
    def index
      @users = User.all.order('created_at DESC')
    end

    def edit; end

    def update; end

    def show; end

    def destory; end
  end
end
