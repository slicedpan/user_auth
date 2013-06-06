$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "user_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "user_auth"
  s.version     = UserAuth::VERSION
  s.authors     = ["Owen Mooney"]
  s.email       = ["omooney@tcd.ie"]
  s.homepage    = "http://slicedpan.org/user_auth"
  s.summary     = "A simple user authentication frameworked backed by db"
  s.description = "A simple user authentication frameworked backed by db"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 3.2.10"
end
