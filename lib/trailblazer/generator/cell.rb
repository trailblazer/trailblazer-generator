module Trailblazer
  module Generator
    class Cell < Cell::ViewModel
      include ::Cell::Erb
      self.view_paths = [File.join(File.dirname(__FILE__), 'builder')]

      def self.controller_path
        util.underscore(name.sub(/Cell$/, '')).split("/")[-1]
      end

      def show
        render
      end
    end
  end
end
