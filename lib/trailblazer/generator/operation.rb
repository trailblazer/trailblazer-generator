module Trailblazer
  module Generator
    class Operation
      class Cell < Trailblazer::Generator::Cell
      end

      def initialize(name, options)
        puts Cell.(name, options)
      end
    end
  end
end
