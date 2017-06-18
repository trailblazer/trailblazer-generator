module Trailblazer
  module Generator
    class Output
      attr_reader :path, :content

      def initialize(path:, content:)
        @path = path
        @content = content
      end

      def save
        FileUtils.mkdir_p(File.dirname(path))
        File.open(path, 'w') do |f|
          f.puts content
        end
        true
      end
    end
  end
end
