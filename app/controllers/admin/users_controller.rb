module Admin
  class UsersController < ApplicationController
    before_action :authorized_only_to_admin!
    before_action :set_user, only: %i[edit update show destroy]
    def index
      @users = User.all.order('created_at DESC').page(params[:page]).per(10)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        @user.approved = true
        @user.email_activate
        redirect_to admin_users_path
      else

        render 'admin/users/new'
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:notice] = "Successfully,updated #{@user.name}'s profile"
        redirect_to admin_users_path
      else
        render 'admin/users/edit'
      end
    end

    def show; end

    def destroy
      @user.destroy
      flash[:notice] = 'Successfully,deleted the user'
      redirect_to admin_users_path
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :profile_image, :education, :experience, :category, :subcategory, :approved, :admin)
    end
  end
end
