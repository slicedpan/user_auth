require "user_auth/session.rb"
require "user_auth/user.rb"
require "user_auth/auth_mixin.rb"
require "user_auth/render.rb"
require "load_tasks.rb"
require "load_views.rb"

ActionController::Base.prepend_view_path File.dirname(__FILE__) + "/../app/views/"
