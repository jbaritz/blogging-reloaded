class ReblogsController < ApplicationController
  before_action :authenticate_user!, :except => [:show]

  def show
    id = params[:id]
    @user = User.find_by(username: params[:username])
    reb = Reblog.find(id)
    if reb.user_id == @user.id
      @reb = reb
    else
      @error = "Error: user does not match reblog!"
    end
  end

  def reblog_from_op_confirm
    @current_page = "reblog this post"
    @post = OriginalPost.find(params[:id])
  end 

  def reblog_from_rb_confirm
    @current_page = "reblog this post"
    @post = Reblog.find(params[:id])
  end

  def reblog_submit
    @post = OriginalPost.find(params[:id])
    params[:original_post_id] = @post.id
    params[:user_id] = current_user.id
    params[:community_post] = false
    if params[:body] != '<p class="line" id="line-1"><br></p>'
      comment = Comment.build_from(@post, current_user.id, params['body'])
      comment.save!
    end
    r = Reblog.create!(reblog_params)
    r.tag_list = params[:tags]
    r.save!
    redirect_to '/'
  end

  private
    def reblog_params
       params.require(:original_post_id)
       params.require(:user_id)
       params.permit(:original_post_id, :user_id, :community_post)
    end

end
