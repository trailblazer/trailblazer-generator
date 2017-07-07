class Trailblazer::Generator::Builder::Cell < Trailblazer::Operation
  class Cell < Trailblazer::Generator::Cell
    def action
      options[:action].capitalize
    end
  end

  step Trailblazer::Generator::Macro::ValidateClassName()
  step :generate_file!
  step Trailblazer::Generator::Macro::Output()
  failure Trailblazer::Generator::Macro::Failure()

  def generate_file!(options, params:)
    options['content'] = Cell.(params[:name], params[:options])

    name = Trailblazer::Generator::Inflector.underscore(params[:name])
    action = Trailblazer::Generator::Inflector.underscore(params[:options][:action])
    options['path'] = File.join('app', 'concepts', name, 'cell', action + '.rb')
  end
end
