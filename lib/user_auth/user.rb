require 'digest/sha1'

module UserAuth
    class User < ActiveRecord::Base
        @@chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
        
        def self.create_salt
            new_pass = ""
            1.upto(20) { |i| new_pass << @@chars[rand(@@chars.length - 1)] }
            new_pass
        end
        
        def self.encrypt(plain_text, salt)
            Digest::SHA1.hexdigest(plain_text + salt)
        end
        
        def password=(plain_text)
            self.password_salt = User.create_salt
            self.password_hash = User.encrypt(plain_text, self.password_salt)
        end
        
        def self.authenticate(username, password)
            u = User.where(:name => username).first
            if u.nil? 
                return u 
            end
            if u.password_hash == User.encrypt(password, u.password_salt)
                u
            else 
                nil
            end
        end
        
        def data
            Marshal.load(self.user_data)
        end
        
        def data=(d)
            self.user_data = Marshal.dump(d)
        end
                
    end       
   
end
