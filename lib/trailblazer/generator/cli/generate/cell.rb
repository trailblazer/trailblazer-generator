module Trailblazer
  module Generator
    class Generate < Thor
      desc "cell NAME", "Generates cell file"
      long_desc <<-CELL_LONG_DESC

      `generate cell` generate cell file

      CELL_LONG_DESC
      options actions: :required
      def cell(name)
        Trailblazer::Generator::Builder::Cell.(name: name, options: options)
      end
    end
  end
end
