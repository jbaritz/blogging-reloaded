class PostsController < ApplicationController
  def new_text_post
    #view  form
  end

  def submit_text_post
    UserTextPost.new(text_params)
  end

  private
  def text_params
     params.require(:post).permit(:title, :content, :tags)
  end

end

