$:.push File.expand_path("../lib", __FILE__)
require "npm/elm/rails/version"

Gem::Specification.new do |s|
  s.name        = "npm-elm-rails"
  s.version     = Npm::Elm::Rails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James Edward Gray II"]
  s.email       = ["james@noredink.com"]
  s.homepage    = "https://github.com/NoRedInk/npm-elm-rails"
  s.summary     = %q{ZZZ}
  s.description = %q{ZZZ}
  s.license     = "MIT"

  s.add_runtime_dependency "railties",     ">= 3.2"
  s.add_runtime_dependency "tilt",         ">= 1.4"
  s.add_runtime_dependency "elm-compiler", "~> 0.2.1"

  s.files         =
    %w[npm-elm-rails.gemspec] +
    Dir.glob("lib/**/*.rb")
  # s.test_files    = ["test/assets_generator_test.rb","test/assets_test.rb","test/controller_generator_test.rb","test/scaffold_generator_test.rb","test/support/routes.rb","test/support/site/index.js.coffee","test/template_handler_test.rb","test/test_helper.rb"]
  s.require_paths = ["lib"]
end
