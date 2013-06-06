# desc "Explaining what the task does"
# task :user_auth do
#   # Task goes here
# end

namespace :user_auth do
    task :create_tables do
    
        base_config = YAML.load_file('config/database.yml')[Rails.env]                
        
        begin                   
            puts "enter root password for db: "
            root_pw = $stdin.gets.strip
            base_config["username"] = "root"
            base_config["password"] = root_pw
            ActiveRecord::Base.establish_connection(base_config)
            con = ActiveRecord::Base.connection
            
            con.execute("delimiter $$
                CREATE TABLE `users` (
                  `user_id` int(11) NOT NULL AUTO_INCREMENT,
                  `password_salt` varchar(32) DEFAULT NULL,
                  `password_hash` varchar(64) DEFAULT NULL,
                  `username` text DEFAULT NULL,
                  `email` text DEFAULT NULL,
                  `user_data` longblob,
                  PRIMARY KEY (`user_id`)
                ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8$$
                delimiter $$
                CREATE TABLE `sessions` (
                  `session_id` varchar(32) NOT NULL,
                  `session_data` longblob,
                  PRIMARY KEY (`session_id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8$$
                ")
        rescue Exception => error
            puts error.message                         
        end
        
    end    
end
