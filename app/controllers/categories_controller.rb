class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :show, :destroy, :update]
  #before_action :require_admin, only: [:edit, :destroy, :update]
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category is created!"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 2)
  end
  
  private
  
  def set_category
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "You need to be admin to perform this action!"
        redirect_to root_path
      end
  end
end