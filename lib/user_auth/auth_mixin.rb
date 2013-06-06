module UserAuth

    module ControllerMixin

        def authenticate_user(username, password)
            @ua_reset_session.call if @ua_reset_session
            @user = User.authenticate(username, password)
            if @user.nil?
                flash[:auth] = {:status => "failure", :message => "Invalid username/password"}
                return false
            end
            session[:user_id] = @user.id
            session[:created_at] = DateTime.now
            session[:updated_at] = DateTime.now
            true
        end
        
        def user_logged_in?
        
            return true unless @user.nil?
            
            uid = session[:user_id]
            @user = User.where(:id => uid).first
            if @user.nil?
                flash[:auth] = {:status => "failure", :message => "Your session is invalid, try logging in again"}
                return false
            end
            
            if session[:created_at] < DateTime.now - 48.hours
                flash[:auth] = {:status => "error", :message => "Your session has expired"}
                return false
            end
            
            if session[:updated_at] < DateTime.now - 10.minutes
                flash[:auth_status] = {:status => "error", :message => "You have been logged out due to inactivity"}
                return false
            end
            
            session[:updated_at] = DateTime.now
            true        
        end
        
        def logout_user
            session[:user_id] = nil
            session[:created_at] = nil
            session[:updated_at] = nil
            flash[:auth] = {:status => "logged_out", :message => "You have successfully logged out"}
        end
        
        def can_view(model)
            
        end
        
        def can_edit(model)
            
        end
        
        def ControllerMixin.included(controller)            
            controller.before_filter :set_login_status                   
            @ua_reset_session = lambda do 
                controller.reset_session
            end
        end
        
        private

            def set_login_status
                puts "blah"
                @auth = flash[:auth]
                if !@auth.nil?
                    if @auth[:status] == "failure"
                        @auth[:class] = "alert-error"
                        @auth[:title] = "Login Failed"
                    elsif @auth[:status] == "error"
                        @auth[:class] = "alert-error"
                        @auth[:title] = "Authorization Error"
                    elsif @auth[:status] == "logged_out"
                        @auth[:class] = "alert-success"
                        @auth[:title] = "Logged Out"
                    end
                end
            end
    end    
end
