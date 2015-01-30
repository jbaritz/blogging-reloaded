class CommentsController < ApplicationController
  def submit_comment
    post = Post.find(params[:id])
    comment = Comment.build_from(post, current_user.id, params['body'])
    comment.save!
    redirect_to "/posts/" + params[:id]
  end
end
