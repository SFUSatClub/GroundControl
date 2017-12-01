class UsersController < ApplicationController

  before_action :skip_password_attribute, only: :update
  before_action :validate_url

  def new
    @user = User.new
  end

  def show
    @user = current_user
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

  def map
  	@user = User.find(params[:id])
  	args = "Hello, world!"
  	#@satellites.each do |sat|
  	#  if @user.preferences[sat.id.to_s] == "1"
  	#    latlong = "[\"" + sat.tle1 + "\",\"" + sat.tle2 + "\"," + "],"
  	#    puts latlong
  	#    args += latlong
  	#  end
  	#end
  	#args += "]"
  	@body_onload = "javascript:init(" + args + ")"
    #respond_to do |format|
    #  format.html {render :file => "./app/views/users/index2.html"}
    #end
  end

  def edit
    @user = current_user
    @satellites = Satellite.all
  end

  def update
    @user = current_user
    params[:user].delete(:password) if params[:user][:password].blank?
    if  @user.update user_params
      notice = "You have updated your favorites."
      flash[:notice] = "#{notice}"
      redirect_back(fallback_location: root_path)
    else
      flash[:warning] = "Something went wrong, we could not save your preferences."
      render :edit
    end
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

    def validate_url
      unless current_user.nil? || params[:id].to_i == current_user.id.to_i
        render :file => 'public/422.html'
      end
    end

end
