class CommentsController < ApplicationController
  before_action :find_commentable, only: :create

  def new
    @comment = Comment.new
  end

  def create
    comment = @commentable.comments.build(comment_params)
    flash[:alert] = 'Комментарий не может быть пустым' unless comment.save
    redirect_to(article_path(comment.article_id))
  end

  private

  def comment_params
    parameters = params.require(:comment).permit(:content, :article_id)
    parameters[:user_id] = current_user.id
    parameters
  end

  def find_commentable
    @commentable =
      if params[:comment_id]
        Comment.find(params[:comment_id])
      else
        Article.find(params[:article_id])
      end
  end
end
