class PostsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :show_all_posts]
  def show #this is okay
    @post = OriginalPost.find(params[:id])
    @comments = @post.comment_threads
    @comments_hash = @comments.map do |c|
      attrs = c.attributes
      attrs[:username] = c.user.username
      attrs
    end  
    @comments_hash = @comments_hash.to_json  
  end

   def show_all_posts #this should be in a profile controller
    @user = User.find_by(username: params[:username])
    @posts = []
    ops = OriginalPost.where(user_id: @user.id).order('created_at DESC').limit(10)
    rblgs = Reblog.where(user_id: @user.id).order('created_at DESC').limit(10)
    ops.each do |p|
      @posts << p
    end
    rblgs.each do |p|
      p = p.original_post
      attrs = p.attributes
      attrs[:op_username] = p.user.username
      @posts << p
    end
    byebug
  end

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


  def show_all_posts #this should be in a profile controller
    @user = User.find_by(username: params[:username])
    @posts = []
    ops = OriginalPost.where(user_id: @user.id).order('created_at DESC').limit(10)
    rblgs = Reblog.where(user_id: @user.id).order('created_at DESC').limit(10)
    byebug
    ops.each do |p|
      @posts << p
    end
    rblgs.each do |p|
      p = p.original_post
      attrs = p.attributes
      attrs[:op_username] = p.user.username
      @posts << p
      byebug
    end
    byebug
    @posts.sort_by! {|p| p.created_at}
    @posts.reverse!
  end


 

  def show_all_posts_json #this should be in a profile controller
    @user = User.find_by(username: params[:username])
    # counter = params[:counter]
    offset = params[:offset]
    # @posts = Post.where(user_id: @user.id).order('created_at DESC').limit(3).offset(2)

    # @posts = Post.where(user_id: @user.id).joins(:media_urls)
    sql = "select * from original_posts left outer join media_urls on media_urls.post_id=original_posts.id where original_posts.user_id = #{@user.id} order by created_at desc limit 2 offset #{offset} "
    @posts = ActiveRecord::Base.connection.execute(sql)
    # @urls = MediaUrl.where(post_id: @posts.id)

    # @newposts = @posts.map do |p|
    #   byebug
    #   attrs = p.attributes
    #   if p.mediaurls.length != 0
    #     attrs[:url] = p.mediaurls.url
    #     attrs[:type] = p.mediaurls.media_type
    #     attrs
    #   end
    # end
    # byebug

    # @posts = Post.where(user_id: @user.id)
    # @posts.each do |post|
    #   byebug
    #   post.created_at = post.created_at.strftime("posted on %m/%d/%Y at %I:%M%p")
    # end
    
    # render :json => @urls
    render :json => @posts
    # render :json => @urls
  end

  def submit_text_post
    params['user_id'] = current_user.id
    params['post_type'] = 'text'
    post = OriginalPost.create!(text_params)
    redirect_to "/"
  end


  def submit_picture_post
    params[:user_id] = current_user.id
    params[:post_type] = 'picture'
    post = OriginalPost.create!(pic_params)
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
    elsif params[:video_url].include?("vine.co")
      params[:url] = params[:video_url].split("/")[-1]
      params[:media_type] = "vine"
    end
    post = OriginalPost.create!(vid_params)
    params[:post_id] = post.id
    MediaUrl.create!(media_params)
    redirect_to "/"
  end

  def submit_audio_post
    params[:user_id] = current_user.id
    OriginalPost.create!(audio_params)
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

