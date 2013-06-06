module UserAuth
    class TaskLoader < Rails::Railtie
        rake_tasks do
            load 'tasks/user_auth_tasks.rake'
        end
    end
end
