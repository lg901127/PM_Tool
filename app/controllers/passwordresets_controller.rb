class PasswordresetsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email params[:email]
    if @user
      #email sent to the email address
      @user.set_token
      flash[:notice] = "Email has been sent"
      redirect_to root_path
    else
      flash[:alert] = "Email is not found"
      redirect_to new_passwordreset_path
    end
  end

  def edit
    @user = User.find_by_reset_token params[:id]
    if @user.password_reset_expired?
      redirect_to root_path, notice: "Link expired!"
    end
  end

  def update
    @user = User.find_by_reset_token params[:id]
    user_params = params.permit(:password, :password_confirmation)
    if @user.update user_params
      @user.unlock_account
      redirect_to root_path, notice: "Information updated!"
    else
      redirect_to edit_user_path(@user), notice: "aaa"
    end
  end

end
