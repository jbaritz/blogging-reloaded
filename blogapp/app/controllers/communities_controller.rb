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
    # @posts = []
    # get = CommunityPost.where(community_id: @comm.id)
    # get.each{ |p|
    #   @posts.push(p.get_post)
    # }
  end

  def posts_json
    @comm = Community.find_by(name: params[:name])
    offset = params[:offset]
    @posts = []
    ops = CommunityPost.where(community_id: @comm.id)
    ops.each { |post|
      p = post.get_post
      attrs = p.attributes
      attrs[:media_url] = p.mediaurls
      attrs[:class] = "OriginalPost"
      attrs[:tags] = p.tag_list.reverse!
      @posts.push(attrs)
      }
    # rbs = Reblog.where(user_id: @user.id, community_post: false).order('created_at DESC').limit(offset.to_i + 10)
    # rbs.each { |r|
    #   attrs = r.attributes
    #   attrs[:class] = "Reblog"
    #   attrs[:original_post] = r.original_post
    #   attrs[:original_user] = r.original_post.user.username
    #   attrs[:media_url] = r.original_post.mediaurls
    #   attrs[:tags] = r.tag_list.reverse!
    #   @posts.push(attrs)
    #   }
    @posts.reverse!
    render :json => @posts
  end

  def join
    params[:user_id] = current_user.id
    params[:admin] = false
    params[:community_id] = Community.where(name: params[:name]).first.id
    CommunityMembership.create!(join_params)
  end

  def user_list_json
    mems = CommunityMembership.where(user_id: current_user.id)
    @comms = []
    mems.each{ |m|
      @comms.push(m.community.name)
    }
    render :json => @comms
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
