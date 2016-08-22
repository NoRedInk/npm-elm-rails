require "tilt/template"

module Npm
  module Elm
    module Rails
      class DependencyProcessor < Tilt::Template
        def prepare
          # do nothing:  no prep needed
        end

        def evaluate(context, _locals, &_block)
          if context.pathname.extname == ".elm"
            add_dependencies(context)
          end
          data
        end

        private

        def add_dependencies(context, path = context.pathname)
          # turn ~/NoRedInk/app/assets/javascripts/Quiz/QuestionStoreAPI.js.elm
          # into ~/NoRedInk/app/assets/javascripts/
          dir =
            path.to_s.sub(/#{Regexp.escape context.logical_path}.*\z/, "")

          File.foreach(path) do |line|
            # e.g. `import Quiz.QuestionStore exposing (..)`
            next unless match = line.match(/\Aimport\s+(?<module>[^\s]+)/)

            # e.g. Quiz.QuestionStore
            module_name = match[:module]
            # e.g. Quiz/QuestionStore
            dependency_logical_name = module_name.tr(".", "/")
            # e.g. ~/NoRedInk/app/assets/javascripts/Quiz/QuestionStore.elm
            dependency_path =
              Pathname.new("#{dir}#{dependency_logical_name}.elm")

            # If we don't find the dependency in our filesystem, assume it's
            # because it comes in through a third-party package rather than our
            # sources.
            next unless dependency_path.file?

            context.depend_on(dependency_logical_name)
            add_dependencies(context, dependency_path)
          end
        end
      end
    end
  end
end
