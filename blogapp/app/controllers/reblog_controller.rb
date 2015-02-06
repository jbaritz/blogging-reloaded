class ReblogController < ApplicationController

  def show
    id = params[:id]
    @user = User.find_by(username: params[:username])
    @reb = Reblog.find(id)
  end
end
