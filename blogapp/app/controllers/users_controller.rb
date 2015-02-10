class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    
  end

  def home
    subscriptions = Subscription.where(subscriber_id: current_user.id)
    @posts = []
    subscriptions.each do |sub|
      post = OriginalPost.where(user_id: sub.subscribee_id)
      reblog = Reblog.where(user_id: sub.subscribee_id)
      @posts.push(post)
    end
    @posts.flatten!
    @posts.sort_by! {|p| p.created_at }
    @posts.reverse! 
  
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
