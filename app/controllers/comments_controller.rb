class CommentsController < ApplicationController
  load_and_authorize_resource :except => :create

  # POST /comments
  # POST /comments.json
  def create
      comentable = comment_params[:commentable_type].constantize.find(comment_params[:commentable_id])
      # Not implemented: check to see whether the user has permission to create a comment on this object
      @comment = Comment.build_from(comentable, current_user.id, comment_params[:body])
      if @comment.save
        @blog = Blog.find(Post.find(@comment.commentable_id).blog_id)
        @comment.update_attribute(:approved, true) if (@blog.user_id.equal? @comment.user_id) || (not @blog.comment_needs_approval)
        make_child_comment
        render :partial => "comments/comment", :locals => { :comments => [] << @comment }, :layout => false, :status => :created
      else
        render :js => "alert('error saving comment');"
      end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.children.destroy_all and @comment.destroy
      render :json => @comment, :status => :ok
    else
      render :js => "alert('error deleting comment');"
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    redirect_to(:back)
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    redirect_to(:back)
  end

  def approve
    @comment = Comment.find(params[:id])
    @comment.update_attribute(:approved, true)
    redirect_to(:back)
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :body, :approved, :commentable_id, :commentable_type, :comment_id)
    end

    def make_child_comment
      return "" if comment_params[:comment_id].blank?

      parent_comment = Comment.find comment_params[:comment_id]
      @comment.move_to_child_of(parent_comment)
    end
end
