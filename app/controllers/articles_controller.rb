class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  def index
    @articles = Article.all

  end

  def show
    @article = Article.find(params[:id])
    #скопировал из comments_controller
    @comment = @article.comments.new
    @users = User.find(@article.user_id).username
  end
################################
  def new
  end

  def create
    @article = Article.new(article_params.merge(user: current_user))
    if @article.save
      redirect_to @article
    else
      render action: 'new'
    end
  end
#################################
  def edit
    if user_signed_in?
    @article = Article.find(params[:id])
  else redirect_to action: 'index'
  end
end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render action: 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end


##########################################
  private

  def article_params
    params.require(:article).permit(:title, :text, :user_id)
  end

#Надо сделать, чтобы работало и вэтом контроллере
  def comment_params
    params.require(:comment).permit(:author, :body)
  end

end
