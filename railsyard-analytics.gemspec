$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "railsyard/analytics/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "railsyard-analytics"
  s.version     = Railsyard::Analytics::VERSION
  s.authors     = ["Stefano Verna"]
  s.email       = ["stefano.verna@gmail.com"]
  s.homepage    = "http://github.com/cantierecreativo/railsyard-analytics"
  s.summary     = "Adds Analytics widgets to your Railsyard dashboard"
  s.description = "Adds Analytics widgets to your Railsyard dashboard"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "railsyard-backend"
  s.add_dependency "garb"
end
