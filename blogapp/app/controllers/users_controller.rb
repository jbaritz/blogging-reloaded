class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    
  end

  def home
 
  end

  def home_feed_json
   subs = User.find(current_user.id).subscribees
   @posts = []
   subs.each do |sub|
      ops = OriginalPost.where(user_id: sub.id, community_post: false)
      rbs = Reblog.where(user_id: sub.id, community_post: false)
      ops.each { |p|
        attrs = p.attributes
        attrs[:user] = p.user.username
        attrs[:media_url] = p.mediaurls
        attrs[:class] = "OriginalPost"
        attrs[:tags] = p.tag_list.reverse!
        @posts.push(attrs)
      }
      rbs.each { |r|
        attrs = r.attributes
        attrs[:user] = p.user.username
        attrs[:class] = "Reblog"
        attrs[:original_post] = r.original_post
        attrs[:original_user] = r.original_post.user.username
        attrs[:media_url] = r.original_post.mediaurls
        attrs[:tags] = r.tag_list.reverse!
        @posts.push(attrs)
      }
    end
    @posts.flatten!
    @posts.sort_by! {|p| p['created_at'] }
    @posts.reverse!  
    render :json => @posts
  end

  def new_subscription
    subscribee = User.where(username: params[:username])
    params[:subscribee_id] = subscribee[0].id
    params[:subscriber_id] = current_user.id
    Subscription.create!(subscription_params)
    redirect_to "/"
  end

  private

  def subscription_params
    # params.require(:subscription)
    params.require(:subscriber_id)
    params.require(:subscribee_id)
    params.permit(:subscriber_id, :subscribee_id)
  end
end
