require 'ostruct'

module Trailblazer
  module Generator
    class Cell < ::Cell::ViewModel
      module ClassMethods
        def build_model(name:, action:)
          OpenStruct.new(name: name, action: action)
        end
      end
      extend ClassMethods

      include ::Cell::Erb
      self.view_paths = [File.join(File.dirname(__FILE__), 'builder')]

      def self.controller_path
        util.underscore(name.sub(/Cell$/, '')).split("/")[-1]
      end

      property :name
      property :action

      def show
        render action
      rescue ::Cell::TemplateMissingError
        render :generic
      end

      def action_class
        Trailblazer::Generator::Inflector.camelize(action)
      end

      def underscore_name
        Trailblazer::Generator::Inflector.underscore(name)
      end
    end
  end
end
