class CommentsController < ApplicationController
  def add_new_comment

    comment = Comment.build_from(post, current_user.id, commenttext )
    comment.save!
end
