module UserAuth
    class ViewLoader < Rails::Railtie
        initializer "user_auth.view_helpers" do
            ActionView::Base.send :include, ViewHelpers
        end
    end
end
