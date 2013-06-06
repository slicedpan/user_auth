module UserAuth
    module ViewHelpers
        def render_alert
            render :partial => 'user_auth/bootstrap_login_message', :locals => {:auth => @auth}
        end    
    end
end
