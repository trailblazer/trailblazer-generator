module Trailblazer
  module Generator
    class Generate < Thor
      desc "contract NAME", "Generates contract file"
      long_desc <<-CONTRACT_LONG_DESC

      `generate contract` generate contract file

      CONTRACT_LONG_DESC
      options actions: :required
      def contract(name)
        Trailblazer::Generator::Builder::Contract.(name: name, options: options)
      end
    end
  end
end
