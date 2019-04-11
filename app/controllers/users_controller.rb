class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t :welcome_to_sample_app
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find params[:id]
  rescue ActiveRecord::RecordNotFound
    render "errors/error_404"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
