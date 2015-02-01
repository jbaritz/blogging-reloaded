class CommentsController < ApplicationController
  def submit_comment
    post = Post.find(params[:id])
    comment = Comment.build_from(post, current_user.id, params['body'])
    comment.save!
    redirect_to "/posts/" + params[:id]
  end

  def reply_to_comment
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:comment_id])
    newcomment = Comment.build_from(post, current_user.id, params['body'])
    newcomment.move_to_child_of(the_desired_parent_comment)

  end
end
