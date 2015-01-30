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
    @user = User.find_by(username: params[:username])
    @posts = Post.where(user_id: @user.id)
  end

  def submit_text_post
    params['user_id'] = current_user.id
    params['post_type'] = 'text'
    # puts "PARAMS:" 
    # puts params
    Post.create!(text_params)
    redirect_to "/"
  end


  def submit_picture_post
    params[:user_id] = current_user.id
    params[:post_type] = 'picture'
    post = Post.create!(pic_params)
    # url_params = {post_id: post.id, url: params["image_url"], media_type: "picture" }
    params[:post_id] = post.id
    params[:url] = params[:image_url]
    params[:media_type] = "picture"
    MediaUrl.create!(media_params)
    redirect_to "/"
  end

  def submit_video_post
    params['user_id'] = current_user.id
    if params[:video_url].include?("outube")
      params[:url] = params[:video_url].split("=")[-1]
      params[:media_type] = "youtube"
    elsif params[:video_url].include?("outu.be")
      params[:url] = params[:video_url].split("/")[-1]
      params[:media_type] = "youtube"
    elsif  params[:video_url].include?("vimeo")
      params[:url] = params[:video_url].split("/")[-1]
      params[:media_type] = "vimeo"
    end
    post = Post.create!(vid_params)
    params[:post_id] = post.id
    MediaUrl.create!(media_params)
    redirect_to "/"
  end

  def submit_audio_post
    params[:user_id] = current_user.id
    Post.create!(audio_params)
    params[:post_id] = post.id
    params[:url] = params[:audio_url]
    params[:media_type] = "audio"
    MediaUrl.create!(media_params)
    redirect_to "/"

  end

  private
    def text_params
       params.require(:user_id)
       params.permit(:title, :content, :user_id, :post_type)
    end

    def pic_params
       params.require(:user_id)
       params.permit(:title, :content, :user_id)
    end

    def vid_params
       params.require(:user_id)
       params.permit(:title, :content, :user_id)
    end

    def audio_params
       params.require(:user_id)
       params.permit(:title, :content, :user_id)
    end

    def media_params
      params.require(:url)
      params.require(:post_id)
      params.require(:media_type)
      params.permit(:url, :post_id, :media_type)

    end
end

