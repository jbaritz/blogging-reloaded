class CommentsController < ApplicationController
  def get_post_comments
   post = Post.find(params[:id])
   @comments = post.comment_threads
   render :json => @comments
  end

  def submit_comment
    post = Post.find(params[:id])
    comment = Comment.build_from(post, current_user.id, params['body'])
    comment.save!
    redirect_to "/posts/" + params[:id]
  end

  def reply_to_comment
    post = Post.find(params[:post_id])
    parent_comment = Comment.find(params[:comment_id])
    new_comment = Comment.build_from(post, current_user.id, params['body'])
    new_comment.move_to_child_of(parent_comment)
    new_comment.save!
    redirect_to "/posts/" + params[:id]

  end
end
