module Trailblazer::Generator::Macro
  REGEXP = /^[A-Z][A-Za-z]{1,}$/ # example: Trailblazer or TrailBlazer
  # Plase, keep error codes sorted alphabetically
  ERROR_INVALID_CLASS_NAME = 1

  def self.ValidateClassName()
    step = ->(input, options) do
      if options["params"][:name].match REGEXP
        true
      else
        options['failure_message'] = 'You provided an invalid class name. Trailblazer or TrailBlazer is expected'
        options['error_code'] = ERROR_INVALID_CLASS_NAME
        false
      end
    end

    [ step, name: "validate_class_name" ]
  end

  def self.Output()
    step = ->(input, options) do
      Trailblazer::Generator::Output.new(path: options['path'], content: options['content']).save
    end

    [ step, name: "output" ]
  end

  def self.Failure()
    step = ->(input, options) do
      puts "Error: " + options['failure_message']
      options['error_code'] ? exit(options['error_code']) : exit(1)
    end

    [ step, name: "failure" ]
  end
end
