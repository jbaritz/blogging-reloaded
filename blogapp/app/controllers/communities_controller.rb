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
  end

  private
  def new_community_params
    params.require(:user_id)
    params.require(:name)
    params.permit(:user_id, :name)
  end
end
