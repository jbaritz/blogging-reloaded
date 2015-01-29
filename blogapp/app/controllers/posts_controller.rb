class PostsController < ApplicationController
  def new_text_post
    #view  form
  end

  def new_picture_post
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
  end

  private
  def text_params
     params.require(:user_id)
     params.permit(:title, :content, :tags, :user_id)
  end

  def pic_params
     params.require(:user_id, :image_url)
     params.permit(:title, :content, :image_url, :user_id)
  end
end

