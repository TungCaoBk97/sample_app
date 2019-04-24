class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        remember_me = params[:session][:remember_me]
        remember_me == Settings.remember_me ? remember(user) : forget(user)
        redirect_back_or user
      else
        flash[:warning] = t "account_activate.not_activate_message"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "flash.invalid_email_password"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
