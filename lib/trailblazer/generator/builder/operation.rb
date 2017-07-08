class Trailblazer::Generator::Builder::Operation < Trailblazer::Operation
  class Cell < Trailblazer::Generator::Cell
    def action
      options[:action].capitalize
    end

    #FIX ME!
    def step_action
      (action == "Create" and options[:present]) ? "new" : "# add_action"
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

    options['path'] = File.join('app', 'concepts', name, 'operation', action + '.rb')
  end
end
