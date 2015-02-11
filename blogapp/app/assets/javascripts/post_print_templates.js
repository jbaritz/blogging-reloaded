<script type="text/template" class="op-text-temp">
	<div id="blog">
	<h2>{{ title }}</h2>
	<p>{{ content }}</p>
	<a href="/<%= @user.username %>/posts/{{ id }}">Comment</a>&nbsp&nbsp<a href='/reblogs/{{ id }}/confirm'>Reblog</a><br>
	</div>
</script>

// <script type="text/template" class="op-template">
// 		<div id="blog">
// 		<h2>{{ post.title }}</h2>
// 		<% {{ media_url }}.each do |media| %>
// 		<% if media.media_type == 'picture' %>
// 			<img src='<%= media.url %>'></img>
// 		<% elsif media.media_type== 'youtube' %>
// 			<div class="flex-video"> 
//         			<iframe width="400" height="225" src="//www.youtube.com/embed/<%= media.url %>" frameborder="0" allowfullscreen></iframe>
// 		 	</div> 
// 		<% elsif media.media_type == 'vimeo' %>
// 			 <div class="flex-video"> 
//         			<iframe src="http://player.vimeo.com/video/<%= media.url %>" width="400" height="225" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>
//         	 </div> 
//         <% elsif media.media_type == 'vine' %>
//         	<iframe src="https://vine.co/v/<%= media.url %>/embed/simple" width="400" height="225" frameborder="0"></iframe><script src="https://platform.vine.co/static/scripts/embed.js"></script>
//         <% end %>
// 	<p>{{ content }}</p> 
// 	<a href="/<%= @user.username %>/posts/{{ id }}">Comment</a>&nbsp&nbsp<a href='/reblogs/{{ id }}/confirm'>Reblog</a><br>
// 	Tags: <% {{ tags }}.reverse!.each_with_index { |tag, index| %>
// 			<% if index == ({{ tags }}.length - 1) %>
// 				<a href="<%= tag %>"><%= tag %></a>
// 			<% else %>
// 			<a href="<%= tag %>"><%= tag %></a> , 
// 			<% end %>
// 		<% } %>
// 	<div id='time'>
// 		<h6><%= {{ created_at }}.strftime("posted on %m/%d/%Y at %I:%M%p") %></h6>
// 	</div>
// 	</div>
// 	</script>
// <script type="text/template" class="rb-template">
// 	<div id="blog">
// 		<h6>originally posted by: <a href="/{{ original_user }}">{{ original_user }}</a></h6>
// 		<h2>{{ original_post.title }}</h2>
// 		<% {{ media_url }}.each do |media| %>
// 		<% if media.media_type == 'picture' %>
// 			<img src='<%= media.url %>'></img>
// 		<% elsif media.media_type == 'youtube' %>
// 		<div class="flex-video"> 
//         			<iframe width="400" height="225" src="//www.youtube.com/embed/<%= media.url %>" frameborder="0" allowfullscreen></iframe>
// 		</div> 
// 		<% elsif media.media_type == 'vimeo' %>
// 			<div class="flex-video"> 
//         			<iframe src="http://player.vimeo.com/video/<%= media.url %>" width="400" height="225" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>
//         	</div> 
//         <% elsif media.media_type == 'vine' %>
//         	<iframe src="https://vine.co/v/<%= media.url %>/embed/simple" width="400" height="225" frameborder="0"></iframe><script src="https://platform.vine.co/static/scripts/embed.js"></script>
//        <% end %>
//         <p>{{ original_post.content }}</p>
//         <a href="/{{ original_user }}/posts/{{ original_post_id }}">Comment</a>&nbsp&nbsp<a href='#'>Reblog</a>
//    	Tags: <% {{ tags }}.reverse!.each_with_index { |tag, index| %>
// 			<% if index == ({{ tags }}.length - 1) %>
// 				<a href="<%= tag %>"><%= tag %></a>
// 			<% else %>
// 			<a href="<%= tag %>"><%= tag %></a> , 
// 			<% end %>
// 		<% } %>
// 	<div id='time'>
// 		<h6><%= {{ created_at }}.strftime("posted on %m/%d/%Y at %I:%M%p") %></h6>
// 	</div>
// 	</div>
// </script>