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

  def submit_text_post
    params['user_id'] = current_user.id
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
       params.permit(:title, :content, :tags, :user_id)
    end

    def pic_params
       params.require(:user_id)
       params.require(:image_url)
       params.permit(:title, :content, :image_url, :user_id, :tags)
    end

    def vid_params
       params.require(:user_id)
       params.require(:video_url)
       params.permit(:title, :content, :video_url, :user_id, :tags)
    end

    def audio_params
       params.require(:user_id)
       params.require(:audio_url)
       params.permit(:title, :content, :audio_url, :user_id, :tags)
    end
end

