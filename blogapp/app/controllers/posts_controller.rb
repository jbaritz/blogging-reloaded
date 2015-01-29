class PostsController < ApplicationController
  def new_text_post
    #view  form
  end

  def submit_text_post
    UserTextPost.new(text_params)
  end

  def show_all_posts
    @posts = []
    @user = User.find_by(username: params[:username])
    @texts = UserTextPost.where(user_id: @user.id)
    @pics = UserPicturePost.where(user_id: @user.id)
    @videos = UserVideoPost.where(user_id: @user.id)
    @posts.push(@texts, @pics, @videos)
    @posts.flatten!
    @posts.sort_by! {|x| x.created_at }
  end

  private
  def text_params
     params.require(:post).permit(:title, :content, :tags)
  end

end

