class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :show, :destroy, :update]
  before_action :require_user, only: [:edit, :create, :destroy, :update]
  before_action :require_same_user, only: [:edit, :destroy, :update]
  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end
  
  def new
    @article = Article.new
  end
  
  def edit
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def update
    @article.user = User.last
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def destroy
    @article.delete
    flash[:warning] = "Article deleted!"
    redirect_to articles_path
  end
  
  private
  def set_article
     @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :description)
  end
  def require_same_user
    if current_user != @article.user
      flash[:danger] = "You can only edit/delete your own articles."
      redirect_to root_path
    end
  end
end