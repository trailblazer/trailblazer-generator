class Trailblazer::Generator::Builder::Operation < Trailblazer::Operation
  class Cell < Trailblazer::Generator::Cell
  end

  step Trailblazer::Generator::Macro::ValidateClassName()
  step :generate_actions!
  failure Trailblazer::Generator::Macro::Failure()

  def generate_actions!(options, params:)
    actions = params[:options]['actions'].split(',')
    actions.each do |action|
      generate_file(options, name: params[:name], action: action)
    end
  end

  private
    def generate_file(options, name:, action:)
      model = Trailblazer::Generator::Cell.build_model(
        name: name, action: action
      )
      params = options['params'][:options]
      content = Cell.(model, params)

      name = Trailblazer::Generator::Inflector.underscore(name)
      path = File.join('app', 'concepts', name, 'operation', "#{action}.rb")

      Trailblazer::Generator::Output.new(path: path, content: content).save
    end
end
