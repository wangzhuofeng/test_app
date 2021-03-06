class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :show, :destroy, :update]
  before_action :require_admin, except: [:index, :show]
  
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
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 2)
  end
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    
  end
  
  def update
    if @category.update(category_params)
      flash[:success] = "Category is updated succesfully!"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end
  
  private
  
  def set_category
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
      if !logged_in? || !current_user.admin?
        flash[:danger] = "You need to be admin to perform this action!"
        redirect_to categories_path
      end
  end
end