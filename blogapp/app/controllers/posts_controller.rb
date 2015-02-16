class PostsController < ApplicationController

  before_action :authenticate_user!, :except => [:show, :show_all_posts]
  
  def show 
    @current_page = ""
    @post = OriginalPost.find(params[:id])
    @comments = @post.comment_threads
    @comments_hash = @comments.map do |c|
      attrs = c.attributes
      attrs[:username] = c.user.username
      attrs
    end  
    @comments_hash = @comments_hash.to_json  
  end

   def show_user_posts 
    @user = User.find_by(username: params[:username])
    @current_page = @user.username
  end

  def show_user_posts_json
    @user = User.find_by(username: params[:username])
    offset = params[:offset]
    @posts = []
    ops = OriginalPost.where(user_id: @user.id, community_post: false).order('created_at DESC').limit(offset.to_i + 10)
    ops.each { |p|
      attrs = p.attributes
      attrs[:media_url] = p.mediaurls
      attrs[:class] = "OriginalPost"
      attrs[:tags] = p.tag_list.reverse!
       attrs[:comments_num] = p.comment_threads.length
      @posts.push(attrs)
      }
    rbs = Reblog.where(user_id: @user.id, community_post: false).order('created_at DESC').limit(offset.to_i + 10)
    rbs.each { |r|
      attrs = r.attributes
      attrs[:class] = "Reblog"
      attrs[:original_post] = r.original_post
      attrs[:original_user] = r.original_post.user.username
      attrs[:media_url] = r.original_post.mediaurls
      attrs[:tags] = r.tag_list.reverse!
      attrs[:comments_num] = r.original_post.comment_threads.length
      @posts.push(attrs)
      }
    @posts.sort_by! {|p| p['created_at']}
    @posts.reverse!
    render :json => @posts
  end

  def new_text_post 
    @current_page = ""
    #view  form
    @target_options = []
    @target_options.push(User.find_by_sql(["SELECT username AS name, id FROM users WHERE id = ? LIMIT 1", current_user.id]).first)
    comms = CommunityMembership.where(user_id: current_user.id)
    comms.each do |c|
      @target_options.push(c.community)  
    end        
  end

  def new_picture_post
    @current_page = ""
    #view  form
     @target_options = []
    @target_options.push(User.find_by_sql(["SELECT username AS name, id FROM users WHERE id = ? LIMIT 1", current_user.id]).first)
    comms = CommunityMembership.where(user_id: current_user.id)
    comms.each do |c|
      @target_options.push(c.community)  
    end
  end

  def new_video_post
      @current_page = ""
    #view  form
     @target_options = []
    @target_options.push(User.find_by_sql(["SELECT username AS name, id FROM users WHERE id = ? LIMIT 1", current_user.id]).first)
    comms = CommunityMembership.where(user_id: current_user.id)
    comms.each do |c|
      @target_options.push(c.community)  
    end
  end

  def new_audio_post
    @current_page = ""
    #view  form
     @target_options = []
    @target_options.push(User.find_by_sql(["SELECT username AS name, id FROM users WHERE id = ? LIMIT 1", current_user.id]).first)
    comms = CommunityMembership.where(user_id: current_user.id)
    comms.each do |c|
      @target_options.push(c.community)  
    end
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
       params.permit(:title, :content, :user_id, :post_type, :community_post, :tag_list => [])
    end

    def vid_params
       params.require(:user_id)
       params.permit(:title, :content, :user_id,:post_type, :community_post, :tag_list => [])
    end

    def audio_params
       params.require(:user_id)
       params.permit(:title, :content, :user_id, :post_type, :community_post, :tag_list => [])
    end

    def media_params
      params.require(:url)
      params.require(:post_id)
      params.require(:media_type)
      params.permit(:url, :post_id, :media_type)
    end

end

