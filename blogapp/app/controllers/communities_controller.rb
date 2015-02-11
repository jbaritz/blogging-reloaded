class CommunitiesController < ApplicationController
  def new
    #new community form
  end

  def create
    params[:user_id] = current_user.id
    newc = Community.create!(new_community_params)
    redirect_to '/communities/' + URI.encode(newc[:name])
  end

  def show
    @comm = Community.where(name: params[:name])[0]
    @is_member = CommunityMembership.where(community_id: @comm.id, user_id: current_user.id).first
    @posts = []
    get = CommunityPost.where(community_id: @comm.id)
    get.each{ |p|
      @posts.push(p.get_post)
    }
  end

  def join
    params[:user_id] = current_user.id
    params[:admin] = false
    params[:community_id] = Community.where(name: params[:name]).first.id
    CommunityMembership.create!(join_params)
  end

  private
  def new_community_params
    params.require(:user_id)
    params.require(:name)
    params.permit(:user_id, :name)
  end

  def join_params
    params.require(:user_id)
    params.require(:community_id)
    params.permit(:user_id, :community_id, :admin)
  end
end
