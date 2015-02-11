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
    ops = OriginalPost.where(user_id: @user.id, community_post: false).order('created_at DESC').limit(10)
    rblgs = Reblog.where(user_id: @user.id, community_post: false).order('created_at DESC').limit(10)
    ops.each do |p|
      @posts << p
    end
    # rblgs = rblgs.map do |p|
    #   attrs = p.attributes
    #   attrs[:op_username] = p.user.username
    # end
    rblgs.each do |p|
      @posts << p
    end
    @posts.sort_by! {|p| p.created_at}
    @posts.reverse!
  end

  def new_text_post 
    #view  form
    @target_options = []
    @target_options.push(User.find_by_sql(["SELECT username AS name, id FROM users WHERE id = ? LIMIT 1", current_user.id]).first)
    comms = CommunityMembership.where(user_id: current_user.id)
    comms.each do |c|
      @target_options.push(c.community)  
    end        
  end

  def new_picture_post
    #view  form
     @target_options = []
    @target_options.push(User.find_by_sql(["SELECT username AS name, id FROM users WHERE id = ? LIMIT 1", current_user.id]).first)
    comms = CommunityMembership.where(user_id: current_user.id)
    comms.each do |c|
      @target_options.push(c.community)  
    end
  end

  def new_video_post
    #view  form
     @target_options = []
    @target_options.push(User.find_by_sql(["SELECT username AS name, id FROM users WHERE id = ? LIMIT 1", current_user.id]).first)
    comms = CommunityMembership.where(user_id: current_user.id)
    comms.each do |c|
      @target_options.push(c.community)  
    end
  end

  def new_audio_post
    #view  form
     @target_options = []
    @target_options.push(User.find_by_sql(["SELECT username AS name, id FROM users WHERE id = ? LIMIT 1", current_user.id]).first)
    comms = CommunityMembership.where(user_id: current_user.id)
    comms.each do |c|
      @target_options.push(c.community)  
    end
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
  end

  def submit_text_post
    selection = params['post-to-options']['selected'].split("-")
    params['user_id'] = selection[0]
    params['post_type'] = 'text'   
    if selection[1] == "User"
      params['community_post'] = false
      post = OriginalPost.create!(text_params)
      post.tag_list = params[:tags]
      post.save!      
    elsif selection[1] == "Community"
      params['community_post'] = true
      post = OriginalPost.create!(text_params)
      post.tag_list = params[:tags]
      post.save!      
      CommunityPost.create!({post_id: post.id, post_type: "OriginalPost", user_id: current_user.id, community_id: selection[0]})
    end
    redirect_to "/"
  end


  def submit_picture_post
    selection = params['post-to-options']['selected'].split("-")
    params[:user_id] = current_user.id
    params[:post_type] = 'picture'
    if selection[1] == "User"
       params[:community_post] = false
       post = OriginalPost.create!(pic_params)
       post.tag_list = params[:tags]
       post.save!
       params[:post_id] = post.id
       params[:url] = params[:image_url]
       params[:media_type] = "picture"
       MediaUrl.create!(media_params)
    elsif selection[1] == "Community"
       params[:community_post] = true
       post = OriginalPost.create!(pic_params)
       post.tag_list = params[:tags]
       post.save!
       params[:post_id] = post.id
       params[:url] = params[:image_url]
       params[:media_type] = "picture"
       MediaUrl.create!(media_params)
       CommunityPost.create!({post_id: post.id, post_type: "OriginalPost", user_id: current_user.id, community_id: selection[0]})
    end
    redirect_to "/"
  end

  def submit_video_post
    selection = params['post-to-options']['selected'].split("-")
    params['user_id'] = current_user.id
    params[:post_type] = 'video'
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
    if selection[1] == "User"
      params[:community_post] = false
      post = OriginalPost.create!(vid_params)
      post.tag_list = params[:tags]
      post.save!     
      params[:post_id] = post.id
      MediaUrl.create!(media_params)
    elsif selection[1] == "Community"
      params[:community_post] = true
      post = OriginalPost.create!(vid_params)
      post.tag_list = params[:tags]
      post.save!     
      params[:post_id] = post.id
      MediaUrl.create!(media_params)
      CommunityPost.create!({post_id: post.id, post_type: "OriginalPost", user_id: current_user.id, community_id: selection[0]})
    end
    redirect_to "/"
  end

  def submit_audio_post
    selection = params['post-to-options']['selected'].split("-")
    params[:user_id] = current_user.id
    params[:post_type] = 'audio'
    if selection[1] == "User"
      params[:community_post] = false
      post = OriginalPost.create!(audio_params)
      post.tag_list = params[:tags]
      post.save!     
      params[:post_id] = post.id
      params[:url] = params[:audio_url]
      params[:media_type] = "audio"
      MediaUrl.create!(media_params)
    elsif selection[1] == "Community"
      params[:community_post] = true
      post = OriginalPost.create!(audio_params)
      post.tag_list = params[:tags]
      post.save!     
      params[:post_id] = post.id
      params[:url] = params[:audio_url]
      params[:media_type] = "audio"
      MediaUrl.create!(media_params)
      CommunityPost.create!({post_id: post.id, post_type: "OriginalPost", user_id: current_user.id, community_id: selection[0]})
    redirect_to "/"
   end
  end

  private
    def text_params
       params.require(:user_id)
       params.permit(:title, :content, :user_id, :post_type, :community_post, :tag_list => [])
    end

    def pic_params
       params.require(:user_id)
       params.permit(:title, :content, :user_id, :community_post, :tag_list => [])
    end

    def vid_params
       params.require(:user_id)
       params.permit(:title, :content, :user_id, :community_post, :tag_list => [])
    end

    def audio_params
       params.require(:user_id)
       params.permit(:title, :content, :user_id, :community_post, :tag_list => [])
    end

    def media_params
      params.require(:url)
      params.require(:post_id)
      params.require(:media_type)
      params.permit(:url, :post_id, :media_type)
    end

end

