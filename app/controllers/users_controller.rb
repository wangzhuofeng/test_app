class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :destroy, :update]
  before_action :require_same_user, only: [:edit, :destroy, :update]
  before_action :require_admin, only: [:destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 8)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Sign up successful! Welcome to Mark's Test App"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      flash[:success] = "Your profile is updated succesfully!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    flash[:danger] = "User and articles are deleted!"
    redirect_to users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    
    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You can only edit your own account."
        redirect_to root_path
      end
    end
    
    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "You need to be admin to perform this action!"
        redirect_to root_path
      end
    end
    
end
