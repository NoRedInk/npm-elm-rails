require "rails/engine"

require_relative "dependency_processor"
require_relative "template"

module Npm
  module Elm
    module Rails
      class Engine < ::Rails::Engine
        initializer :register_elm do |app|
          app.assets.register_processor(
            "application/javascript", Npm::Elm::Rails::DependencyProcessor
          )
          app.assets.register_engine(".elm", Npm::Elm::Rails::Template)
        end
      end
    end
  end
end
