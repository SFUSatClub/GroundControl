class UsersController < ApplicationController

  before_action :skip_password_attribute, only: :update

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "You have successfully registered!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @satellites = Satellite.all
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    @user.update user_params
    notice = "You have updated your favorites."
    flash[:notice] = "#{notice}"
    redirect_back(fallback_location: root_path)


    # if @user.update user_params
    #   notice = "You have updated your favorites."
    #   flash[:notice] = "#{notice}"
    #   redirect_back(fallback_location: root_path)
    # else
    #   render :edit
    # end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :preferences => {})
    end

    def skip_password_attribute
      if params[:password].blank? && params[:password_confirmation].blank?
        params.except(:password, :password_confirmation)
      end
    end

end
