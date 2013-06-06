# desc "Explaining what the task does"
# task :user_auth do
#   # Task goes here
# end

namespace :user_auth
    task :create_tables do
        config = YAML.load_file('config/database.yml')[Rails.env]
    end    
end
