class UsersController < ApplicationController
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :set_username
  # before_action :set_user
  #by default, filters apply to every action in a controller,
  # so we restrict the filter to act only on the edit and update actions
  # by passing the appropriate only options hash

  respond_to :html, :json

  def index
    @user = set_username
    @get_user = User.find(params[:id])
    @outlines = @get_user.outlines
    # @users = User.paginate(page: params[:page])
    #paginate takes a hash argument with key :page and a value eq to the page number
    #User.paginate defaults to pull 30 users out of the database at a time based on
    #the page parameter
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "Profile updated"
        format.html {render :show}
        format.json {render :show}
      else
        format.html { render :edit}
        format.json { render :show}
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @username = @user.name
    @outlines = @user.outlines
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      # redirect_to @user
      redirect_to @user
      #we can omit the user_url in the redirect.
    else
      render 'new'
      #it doesn't make sense for a view to correspond
      #to a post request, such as create. We therefore redirect to 'new', which will GET the
      # view corresponding to they newly created user. Chha.
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  # def set_user
  #   @user = User.find(params[:id])
  # end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user == @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :color)
  end

  def set_username
    if @user
      @user = User.find(params[:id])
      @username = @user.name
    end
  end
  #note that admin is not a permitted attribute. This is what prevents users from
  #assigning themselves admin status.
end
