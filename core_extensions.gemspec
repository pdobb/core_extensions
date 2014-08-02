$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "core_extensions/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "core_extensions"
  s.version     = CoreExtensions::VERSION
  s.authors     = ["Paul Dobbins"]
  s.email       = ["pdobbins@gmail.com"]
  s.homepage    = "https://github.com/pdobb/core_extensions"
  s.summary     = "A collection of Ruby/Rails Core Extensions."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "minitest-rails"
  s.add_development_dependency "minitest-ansi"
  s.add_development_dependency "wrong"
end
