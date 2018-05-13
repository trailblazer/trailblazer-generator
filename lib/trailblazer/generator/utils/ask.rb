module Trailblazer
  class Generator
    module Utils
      # Ask if overwrite when file already exists
      class Ask
        def initialize
          @menu = Menu.new
        end

        def overwrite?(context)
          @menu.overwrite(context)
        end
      end
    end
  end
end
