[1mdiff --git a/app/assets/javascripts/common/nav.js b/app/assets/javascripts/common/nav.js[m
[1mindex bbd0241..b8c21f9 100644[m
[1m--- a/app/assets/javascripts/common/nav.js[m
[1m+++ b/app/assets/javascripts/common/nav.js[m
[36m@@ -67,13 +67,6 @@[m
                         window.nav.scrollToActive();[m
                         window.nav.setScrollIndicator();[m
                 }[m
[31m-                $(document).scroll(function() {[m
[31m-                        if (document.body.scrollTop > 1500) {[m
[31m-                                $("#toTop").show();[m
[31m-                        } else {[m
[31m-                                $("#toTop").hide();[m
[31m-                        }[m
[31m-                });[m
         });[m
 [m
 })();[m
[1mdiff --git a/app/assets/javascripts/topics.js b/app/assets/javascripts/topics.js[m
[1mindex 85ef7b3..7e67adf 100644[m
[1m--- a/app/assets/javascripts/topics.js[m
[1m+++ b/app/assets/javascripts/topics.js[m
[36m@@ -5,6 +5,7 @@[m
                 self.resizePostsFrame = function(obj) {[m
                         setTimeout(function() {[m
                                 $("#spinner").hide();[m
[32m+[m[32m                                obj.style.height = 0;[m
                                 obj.style.height = obj.contentWindow.document.body.scrollHeight + "px";[m
                         }, 500);[m
                 };[m
[36m@@ -49,6 +50,7 @@[m
         $(function() {[m
                 $("#posts").load(function() {[m
                         window.topics.resizePostsFrame(this);[m
[32m+[m[32m                        $(".redactor-editor").html("");[m
                 }).attr("src", "/topics/"+$("#topicId").val()+"/posts");[m
         });[m
 [m
[1mdiff --git a/app/assets/stylesheets/topics.scss b/app/assets/stylesheets/topics.scss[m
[1mindex c0325e0..c7371ec 100644[m
[1m--- a/app/assets/stylesheets/topics.scss[m
[1m+++ b/app/assets/stylesheets/topics.scss[m
[36m@@ -166,4 +166,13 @@[m
         height: 48px;[m
         width: 100%;[m
     }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m.back-to-top {[m
[32m+[m[32m    background: transparent;[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    outline: none;[m
[32m+[m[32m    i {[m
[32m+[m[32m        margin-right: 4px;[m
[32m+[m[32m    }[m
 }[m
\ No newline at end of file[m
[1mdiff --git a/app/controllers/chat_controller.rb b/app/controllers/chat_controller.rb[m
[1mindex 383cec5..92ea487 100644[m
[1m--- a/app/controllers/chat_controller.rb[m
[1m+++ b/app/controllers/chat_controller.rb[m
[36m@@ -2,12 +2,35 @@[m
 class ChatController < ApplicationController[m
 [m
         before_action :set_back_url[m
[32m+[m[32m        skip_authorize_resource[m
 [m
         def index[m
                 render layout: false[m
         end[m
 [m
[32m+[m[32m        def create[m
[32m+[m[32m                @chat = Chat.new(chat_params)[m
[32m+[m[32m                if @chat.save![m
[32m+[m[32m                        render plain: "ok"[m
[32m+[m[32m                else[m
[32m+[m[32m                        render plain: "failed"[m
[32m+[m[32m                end[m
[32m+[m[32m        end[m
[32m+[m
[32m+[m[32m        def latest[m
[32m+[m[32m                @chats = Chat.order(id: :desc).limit(20)[m
[32m+[m[32m                render json: @chats[m
[32m+[m[32m        end[m
[32m+[m
[32m+[m[32m        def history[m
[32m+[m[32m                @chats = Chat.where("created_at > ?", DateTime.now.days_ago(params[:time].to_i)).order(id: :acs).paginate(page: params["page"])[m
[32m+[m[32m                @title = "聊天历史记录"[m
[32m+[m[32m        end[m
[32m+[m
         private[m
[32m+[m[32m        def chat_params[m
[32m+[m[32m                params[:chat].permit(:text, :user_name, :user_avatar)[m
[32m+[m[32m        end[m
         def set_back_url[m
                 @title = "聊天室"[m
                 @back_url = root_url[m
[1mdiff --git a/app/controllers/posts_controller.rb b/app/controllers/posts_controller.rb[m
[1mindex a7aaa72..373fcc1 100644[m
[1m--- a/app/controllers/posts_controller.rb[m
[1m+++ b/app/controllers/posts_controller.rb[m
[36m@@ -20,10 +20,10 @@[m [mclass PostsController < ApplicationController[m
 [m
                 respond_to do |format|[m
                         if @post.save![m
[31m-                                format.html { redirect_to @topic, notice: "创建成功" }[m
[32m+[m[32m                                format.html { redirect_to topic_posts_url(params[:topic_id]), notice: "评论发表成功！" }[m
                                 format.json { render :show, status: :created, location: @post }[m
                         else[m
[31m-                                format.html { redirect_to @topic, notice: "创建成功" }[m
[32m+[m[32m                                format.html { redirect_to topic_posts_url(params[:topic_id]), notice: "评论发表失败！" }[m
                                 format.json { render json: @post.errors, status: :unprocessable_entity }[m
                         end[m
                 end[m
[1mdiff --git a/app/views/layouts/application.html.erb b/app/views/layouts/application.html.erb[m
[1mindex 461ffc2..14855d7 100644[m
[1m--- a/app/views/layouts/application.html.erb[m
[1m+++ b/app/views/layouts/application.html.erb[m
[36m@@ -37,9 +37,6 @@[m
     </footer>[m
 [m
     <div class="block-layer"></div>[m
[31m-    <button class="fab" id="toTop" onclick="utility.toTop()">[m
[31m-      <i class="glyphicon glyphicon-arrow-up"></i>[m
[31m-    </button>[m
 [m
     <%= javascript_include_tag 'application' %>[m
     <%= javascript_include_tag params[:controller] %>[m
[1mdiff --git a/app/views/posts/index.html.erb b/app/views/posts/index.html.erb[m
[1mindex 510db3d..08bb6a7 100644[m
[1m--- a/app/views/posts/index.html.erb[m
[1m+++ b/app/views/posts/index.html.erb[m
[36m@@ -7,7 +7,19 @@[m
   </head>[m
   <body>[m
     <div>[m
[32m+[m[32m      <% if notice.present? %>[m
[32m+[m[32m      <div class="alert alert-info" role="alert">[m
[32m+[m[32m        <%= notice %>[m
[32m+[m[32m      </div>[m
[32m+[m[32m      <% end %>[m
[32m+[m[32m      <% if alert.present? %>[m
[32m+[m[32m      <div class="alert alert-danger" role="alert">[m
[32m+[m[32m        <%= alert %>[m
[32m+[m[32m      </div>[m
[32m+[m[32m      <% end %>[m
[32m+[m[32m    </div>[m
 [m
[32m+[m[32m    <div>[m
       <% @posts.each do |p| %>[m
         <div>[m
           <div class="post">[m
[1mdiff --git a/app/views/topics/show.html.erb b/app/views/topics/show.html.erb[m
[1mindex 4fd5896..f858576 100644[m
[1m--- a/app/views/topics/show.html.erb[m
[1m+++ b/app/views/topics/show.html.erb[m
[36m@@ -33,8 +33,12 @@[m
     </div>[m
   </div>[m
   <div class="col-xs-12 col-md-12 topic-info">[m
[31m-    <span>发表于：<%=display_datetime @topic.created_at%></span>[m
[32m+[m[32m    <span class="pull-left">发表于：<%=display_datetime @topic.created_at%></span>[m
[32m+[m[32m    <button class="back-to-top" id="toTop" onclick="utility.toTop()">[m
[32m+[m[32m      <i class="glyphicon glyphicon-arrow-up"></i> Top[m
[32m+[m[32m    </button>[m
   </div>[m
[32m+[m
 </div>[m
 [m
 <div class="posts row">[m
[36m@@ -43,13 +47,13 @@[m
   </div>[m
   <div class="col-xs-12 col-sm-10">[m
     <%=image_tag "spinner.gif", id: "spinner", class: "spinner" %>[m
[31m-    <iframe frameborder="0" scrolling="no" width="100%" height="0" id="posts">[m
[32m+[m[32m    <iframe frameborder="0" scrolling="no" width="100%" height="0" id="posts" name="posts">[m
     </iframe>[m
   </div>[m
 </div>[m
 [m
 <div class="new-post">[m
[31m-  <%= form_for([@topic, @topic.posts.build]) do |f|%>[m
[32m+[m[32m  <%= form_for([@topic, @topic.posts.build], html: {target: "posts"}) do |f|%>[m
     <div class="row">[m
       <%=f.label :content, "回复", class: "control-label col-md-2 col-xs-12"%>[m
       <div class="col-md-10 col-xs-12">[m
[1mdiff --git a/config/routes.rb b/config/routes.rb[m
[1mindex 989195b..a33b8cc 100644[m
[1m--- a/config/routes.rb[m
[1m+++ b/config/routes.rb[m
[36m@@ -12,7 +12,7 @@[m [mRails.application.routes.draw do[m
 	post "redactor_rails/pictures" => "images#create"[m
 	post "topics/:id/like" => "topics#like"[m
 	get "topics/search" => "topics#search"[m
[31m-	[m
[32m+[m
 	resources :topics do[m
 		resources :posts[m
 	end[m
[36m@@ -20,6 +20,9 @@[m [mRails.application.routes.draw do[m
 	resources :users[m
 [m
 	get "chat" => "chat#index"[m
[32m+[m	[32mpost "chat" => "chat#create"[m
[32m+[m	[32mget "chat/latest" => "chat#latest"[m
[32m+[m	[32mget "chat/history" => "chat#history"[m
 [m
 	post "images" => "images#create"[m
         # The priority is based upon order of creation: first created -> highest priority.[m
[1mdiff --git a/db/schema.rb b/db/schema.rb[m
[1mindex 6787378..b50d44b 100644[m
[1m--- a/db/schema.rb[m
[1m+++ b/db/schema.rb[m
[36m@@ -11,7 +11,7 @@[m
 #[m
 # It's strongly recommended that you check this file into your version control system.[m
 [m
[31m-ActiveRecord::Schema.define(version: 20160114042349) do[m
[32m+[m[32mActiveRecord::Schema.define(version: 20160115053359) do[m
 [m
   create_table "captchas", force: :cascade do |t|[m
     t.string   "tel",              limit: 11, null: false[m
[36m@@ -29,6 +29,14 @@[m [mActiveRecord::Schema.define(version: 20160114042349) do[m
     t.datetime "updated_at",             null: false[m
   end[m
 [m
[32m+[m[32m  create_table "chats", force: :cascade do |t|[m
[32m+[m[32m    t.text     "text",        limit: 65535[m
[32m+[m[32m    t.string   "user_name",   limit: 255[m
[32m+[m[32m    t.string   "user_avatar", limit: 255[m
[32m+[m[32m    t.datetime "created_at",                null: false[m
[32m+[m[32m    t.datetime "updated_at",                null: false[m
[32m+[m[32m  end[m
[32m+[m
   create_table "posts", force: :cascade do |t|[m
     t.text     "content",    limit: 65535[m
     t.integer  "favorite",   limit: 4[m
