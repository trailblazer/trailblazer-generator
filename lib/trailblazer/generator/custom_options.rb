require "yaml"
require "dry-validation"

module Trailblazer
  module Generator
    class CustomOptions < Trailblazer::Activity::Railway
      class OptionsSchema < Dry::Validation::Contract
        schema do
          optional(:view).value(:str?)
          optional(:stubs).value(:str?)
          optional(:add_type_to_namespace).value(:str?)
          optional(:app_dir).value(:str?)
          optional(:concepts_folder).value(:str?)
          optional(:activity_strategy).value(:str?)

          optional(:file_list).schema do
            optional(:operation).value(:array?)
            optional(:cell).value(:array?)
            optional(:contract).value(:array?)
            optional(:finder).value(:array?)
            optional(:view).value(:array?)
            optional(:activity).value(:array?)
          end
        end
      end

      def file_exists?(ctx, file_path: "./trailblazer_generator.yml", **)
        ctx[:file_path] = file_path
        ctx[:custom_options] = {file_list: {}}
        File.exist?(file_path)
      end

      def custom_options(ctx, file_path:, **)
        ctx[:custom_options] = YAML.load_file(file_path)
      end

      def check_file_format(_ctx, custom_options:, **)
        custom_options.is_a?(Hash)
      end

      def symbolize_keys(ctx, custom_options:, **)
        ctx[:custom_options] = Trailblazer::Generator::Utils::Hash.deep_symbolize(custom_options)
        ctx[:custom_options][:file_list] ||= {}
      end

      def validate_content(ctx, custom_options:, **)
        schema = OptionsSchema.new
        ctx[:errors_messages] = schema.call(custom_options).messages(full: true).map { |key, error|
          if key == :file_list
            message = ["file_list: "]
            message << error.map { |_key, value| value }.join(", ")
            message.join
          else
            error
          end
        }.flatten.join(", ")
        ctx[:errors_messages] == ""
      end

      def warn_user(ctx, errors_messages: nil, **)
        ctx[:custom_options] = {file_list: {}}
        Utils::Say.new.wrong_file_content(errors_messages)
      end

      def override_default_options(_ctx, custom_options:, **)
        Trailblazer::Generator.configure do |config|
          custom_options.each do |key, value|
            next if key == :file_list

            config.public_send("#{key}=", value)
          end

          custom_options[:file_list].each do |key, value|
            config.file_list.public_send("#{key}=", value)
          end
        end
      end

      pass :file_exists?, Output(:failure) => End(:success)
      step :custom_options
      step :check_file_format
      step :symbolize_keys
      step :validate_content
      fail :warn_user, id: :warn_user
      pass :override_default_options
    end
  end
end
