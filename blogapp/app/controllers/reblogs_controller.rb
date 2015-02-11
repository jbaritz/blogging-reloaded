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

  def confirm
    @post = OriginalPost.find(params[:id])
  end

  def reblog_post
    @post = OriginalPost.find(params[:id])
    params[:original_post_id] = @post.id
    params[:user_id] = current_user.id
    params[:community_post] = false
    Reblog.create!(reblog_params)
    redirect_to '/'
  end

  private
    def reblog_params
       params.require(:original_post_id)
       params.require(:user_id)
       params.permit(:original_post_id, :user_id, :community_post)
    end

end
