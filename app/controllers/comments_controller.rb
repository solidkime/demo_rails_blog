class CommentsController < ApplicationController
   before_filter :authenticate_user!, :only => [:new, :create]
  def create
    @article = Article.find(params[:article_id])
    @article.comments.create(author: current_user.username, body: comment_params[:body])

    redirect_to article_path(@article)
  end



  private

  def comment_params
    params.require(:comment).permit(:author, :body)
  end

end
