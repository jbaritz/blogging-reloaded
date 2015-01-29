class PostsController < ApplicationController
  def new_text_post
    #view  form
  end

  def new_picture_post
    #view  form
  end

  def new_video_post
    #view  form
  end

  def new_audio_post
    #view  form
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

  def submit_text_post
    params['user_id'] = current_user.id
    params['type'] = 'text'
    # puts "PARAMS:" 
    # puts params
    UserTextPost.create!(text_params)
    redirect_to "/"
  end


  def submit_picture_post
    params['user_id'] = current_user.id
    UserPicturePost.create!(pic_params)
    redirect_to "/"
  end

  def submit_video_post
    params['user_id'] = current_user.id
    if params[:video_url].include?("outube")
      params[:video_url] = params[:video_url].split("=")[1]
      params[:vid_type] = "youtube"
    elsif params[:video_url].include?("outu.be")
      params[:video_url] = params[:video_url].split("/")[-1]
      params[:vid_type] = "youtube"
    elsif  params[:video_url].include?("vimeo")
      params[:video_url] = params[:video_url].split("/")[-1]
      params[:vid_type] = "vimeo"
    end
    UserVideoPost.create!(vid_params)
    redirect_to "/"
  end

  def submit_audio_post
    params['user_id'] = current_user.id
    UserAudioPost.create!(audio_params)
    redirect_to "/"

  end

  private
    def text_params
       params.require(:user_id)
       params.permit(:title, :content, :tags, :user_id, :type)
    end

    def pic_params
       params.require(:user_id)
       params.require(:image_url)
       params.permit(:title, :content, :image_url, :user_id, :tags)
    end

    def vid_params
       params.require(:user_id)
       params.require(:video_url)
       params.permit(:title, :content, :video_url, :user_id, :tags, :vid_type)
    end

    def audio_params
       params.require(:user_id)
       params.require(:audio_url)
       params.permit(:title, :content, :audio_url, :user_id, :tags)
    end
end

