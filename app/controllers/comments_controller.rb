class CommentsController < ApplicationController
  before_action :check_user_login
  def create

	  @comment = Comment.new(comment_params)
	  @comment.tweet_id = params[:tweet_id]
	  @comment.user_id = @current_user.id
	  @comment.save
  
    redirect_to @comment.tweet
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
