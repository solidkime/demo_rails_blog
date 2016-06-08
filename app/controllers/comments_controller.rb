class CommentsController < ApplicationController
   before_filter :authenticate_user!, :only => [:new, :create]

   def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(author: current_user.username, body: comment_params[:body])

    if @comment.save  
       redirect_to article_path(@article)
    else
       flash[:error] = @comment.errors
       redirect_to article_path(@article)
     end
  end



  private

  def comment_params
    params.require(:comment).permit(:author, :body)
  end

end
