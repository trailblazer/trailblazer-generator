class Trailblazer::Generator::Builder::View < Trailblazer::Operation
  class Cell < Trailblazer::Generator::Cell
  end

  step Trailblazer::Generator::Macro::ValidateClassName()
  step :generate_actions!
  failure Trailblazer::Generator::Macro::Failure()

  def generate_actions!(options, params:)
    actions = params[:options]['actions'].split(',')
    template_engine = params[:options]['template_engine']
    actions.each do |action|
      generate_file(options, name: params[:name], action: action, template_engine: template_engine)
    end
  end

  private
    def generate_file(options, name:, action:, template_engine:)
      model = Trailblazer::Generator::Cell.build_model(
        name: name, action: action
      )
      params = options['params'][:options]
      content = Cell.(model, params)

      name = Trailblazer::Generator::Inflector.underscore(name)
      path = File.join('app', 'concepts', name, 'view', "#{action}.#{template_engine}")

      Trailblazer::Generator::Output.new(path: path, content: content).save
    end
end
