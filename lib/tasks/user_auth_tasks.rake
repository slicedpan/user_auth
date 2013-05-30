# desc "Explaining what the task does"
# task :user_auth do
#   # Task goes here
# end

namespace :user_auth
    task :create_tables do
        class create_user_session_tables < ActiveRecord::Migration
            def change
                create_table(:users, :primary_key => 'id') do |u|
                    u.integer :id
                    u.string :name
                    u.string :email
                    u.string :password_hash
                    u.string :password_salt
                    u.column :data, :binary, :limit => 10.megabytes
                    u.column :permissions, :binary, :limit => 10.megabytes
                end
                create_table(:sessions, :primary_key => 'id') do |s|
                    s.string :id
                    s.column :data, :binary, :limit => 1.megabytes
                end
            end
        end
    end    
end
