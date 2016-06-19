class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "You are logged in!"
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update

    @user = User.find params[:id]
    byebug
    user_params = params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    old_password = params[:old_password]
    if @user.authenticate(old_password)
      if @user.update user_params
        redirect_to root_path, notice: "Information updated!"
      else
        redirect_to edit_user_path(@user), notice: "aaa"
      end
    else
      # @user.errors.add(:password, "The password you entered is not your current password")
      flash[:alert] = "INCORRECT CURRENT PASSWORD"
      redirect_to edit_user_path(@user)
    end
  end



end
