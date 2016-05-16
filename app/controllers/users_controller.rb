class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/[:id]
  def show

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to "/log_in" }
      else
        format.html { render :new }
      end
    end
    end

  private

    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
