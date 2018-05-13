module Trailblazer
  # Trailblazer Gen
  class Generator
    # Generator commands registry
    module Utils
      # Fetch Options
      class Menu
        def initialize
          @prompt = Prompt.new prefix: "\t", interrupt: :exit
          @pastel = Pastel.new
        end

        def overwrite(destination)
          choices = [
            {key: "y", name: @pastel.green("Yes"), value: true},
            {key: "n", name: @pastel.red("No"), value: false}
          ]
          @prompt.expand("#{@pastel.yellow("Exists")}:\t#{destination.ljust(55, " ")} - Overwrite?", choices, default: 2)
        end

        def abort
          exit(1)
        end
      end
    end
  end
end
