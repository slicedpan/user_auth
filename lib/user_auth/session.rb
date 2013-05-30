module UserAuth
    class Session < ActiveRecord::Base
        def self.find_by_session_id(sess_id)
            Session.where(session_id => sess_id).first           
        end
        
        def initialize(id_and_data, options_hash = {})
            super({}, options_hash)
            self.data = id_and_data[:data]
            self.session_id = id_and_data[:session_id]
        end
        
        def data
            Marshal.load(self.session_data)
        end
        
        def data=(d)
            self.session_data = Marshal.dump(d)
        end        
    end
end
