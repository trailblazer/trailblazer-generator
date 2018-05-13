module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Utils
      # Fetch Options
      class Say
        def initialize
          @prompt = Prompt.new prefix: "\t"
          @pastel = Pastel.new
        end

        def create(destination)
          @prompt.say("\t#{@pastel.green("Create")}:\t#{destination}")
        end

        def notice(message)
          @prompt.say("\t#{@pastel.magenta("Notice")}:\t#{message}")
        end

        def start(type)
          @prompt.say("\n    Starting Generator for Trailblazer #{type.capitalize}\n")
        end

        def end(type)
          @prompt.say("    Ending Generator for Trailblazer #{type.capitalize}\n")
        end

        def close
          @prompt.say("\n")
        end
      end
    end
  end
end
