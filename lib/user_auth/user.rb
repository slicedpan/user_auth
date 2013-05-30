require 'digest/sha1'

module UserAuth
    class User < ActiveRecord::Base
        @@chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
        
        self.create_salt
            new_pass = ""
            1.upto(20) { |i| new_pass << @@chars[rand(@@chars.length - 1)] }
            new_pass
        end
        
        def password=(plain_text)
            self.password_salt = self.create_salt
            self.password_hash = Digest::SHA1.hexdigest(plain_text + self.password_salt)
        end
        
        def self.authenticate(username, password)
            u = User.where(:name => username).first
        end        
    end 
       
    def authenticate(username, password)
        @user = User.authenticate(username, password)
        if @user.nil?
            flash[:auth_status] = "error"
            flash[:auth_message] = "Invalid username/password"
            return false
        end
        session[:user_id] = u.id
        session[:created_at] = DateTime.now
        session[:updated_at] = DateTime.now
        true
    end
    
    def restore
        uid = session[:user_id]
        @user = User.where(:id => uid).first
        if @user.nil?
            flash[:auth_status] = "error"
            flash[:auth_message] = "Your session is invalid, try logging in again"
            return false
        end
        
        if session[:created_at] < DateTime.now - 48.hours
            flash[:auth_status] = "error"
            flash[:auth_message] = "Your session has expired"
            return false
        end
        
        if session[:updated_at] < DateTime.now - 10.minutes
            flash[:auth_status] = "error"
            flash[:auth_message] = "You have been logged out due to inactivity"
            return false
        end
        
        session[:updated_at] = DateTime.now
        true        
    end
    
    def logout
        session[:user_id] = nil
        flash[:auth_status] = "logged_out"
        flash[:auth_message] = "You have successfully logged out"
    end
    
    def can_view(model)
        
    end
    
    def can_edit(model)
        
    end
end
