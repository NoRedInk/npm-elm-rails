require "pathname"

require "tilt/template"
require "elm-compiler"

module Npm
  module Elm
    module Rails
      class Template < Tilt::Template
        ELM_MAKE_PATH = "#{`npm bin`.strip}/elm-make"

        self.default_mime_type = "application/javascript"

        def prepare
          # do nothing:  no prep needed
        end

        def evaluate(scope, locals, &block)
          Dir.chdir(elm_package_root) do
            ::Elm::Compiler.compile(file, elm_make_path: ELM_MAKE_PATH)
          end
        end

        private

        def elm_package_root
          dir = Pathname.new(file).dirname
          loop do
            elm_package = dir + "elm-package.json"
            return dir.to_s if elm_package.exist?

            fail "Could not find elm-package.json" if dir.to_s == "/"
            dir = dir.parent
          end
        end
      end
    end
  end
end
