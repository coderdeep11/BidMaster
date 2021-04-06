class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by_email(params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      if @user.email_confirmed
        session[:user_id] = @user.id
        flash[:notice] = "Hi #{@user.name},you have signed in successfully. "
        redirect_to root_path
      else
        flash[:alert] = 'Please activate your account by following the
          instructions in the account confirmation email you received, to proceed'
        redirect_to login_path
      end
    else
      flash[:alert] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end

  def confirm_email
    user = User.find_by_confirmation_token(params[:id])
    if user
      user.email_activate
      flash[:alert] = "Welcome to the Bidmaster! Your email has been confirmed.
        Please sign in to continue."
      redirect_to login_path
    else
      flash[:alert] = 'Sorry. User does not exist'
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have signed out successfully. '
    redirect_to root_path
  end
end
