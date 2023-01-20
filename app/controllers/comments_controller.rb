class CommentsController < ApplicationController

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.new(comment_params)
    # @comment = Comment.new(comment_params)
    if @comment.save
      # 下記はcommentと結びつくprototypeの詳細画面に遷移する
      redirect_to prototype_path(@comment.prototype)
    else
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
