class Trailblazer::Generator::Builder::Cell < Trailblazer::Operation
  class Cell < Trailblazer::Generator::Cell
  end

  step Trailblazer::Generator::Macro::ValidateClassName()
  step :generate_actions!
  step :generate_views!
  failure Trailblazer::Generator::Macro::Failure()

  def generate_actions!(options, params:)
    actions = params[:options]['actions'].split(',')
    actions.each do |action|
      generate_file(options, name: params[:name], action: action)
      generate_file(options, name: params[:name], action: 'item') if action == 'Index'
    end
  end

  def generate_views!(options, params:)
    options_dup = params[:options].dup
    actions = params[:options]['actions'].dup
    if actions.match /index/i
      actions << ',item'
      options_dup['actions'] = actions
    end
    Trailblazer::Generator::Builder::View.(name: params[:name], options: options_dup)
    true
  end

  private
    def generate_file(options, name:, action:)
      model = Trailblazer::Generator::Cell.build_model(
        name: name, action: action
      )
      params = options['params'][:options]
      content = Cell.(model, params)

      name = Trailblazer::Generator::Inflector.underscore(name)
      path = File.join('app', 'concepts', name, 'cell', "#{action}.rb")

      Trailblazer::Generator::Output.new(path: path, content: content).save
    end
end
