class Trailblazer::Generator::Builder::Cell < Trailblazer::Operation
  class Cell < Trailblazer::Generator::Cell
  end

  step Trailblazer::Generator::Macro::ValidateClassName()
  step :generate_actions!
  step :create_files!
  step :generate_views!
  failure Trailblazer::Generator::Macro::Failure()

  def generate_actions!(options, params:, **)
    actions = params[:options]['actions'].split(',')
    options["cell_result"] = {"files_content" => [], "files_path" => []}
    actions.each do |action|
      options["cell_result"] = generate_file(options, params: params, action: action)
      options["cell_result"] = generate_file(options, params: params, action: 'item') if action == 'Index'
    end
  end

  def create_files!(options, params:, **)
    debug = (params[:options]["debug"] ||= false)
    return true if debug
    contents = options["cell_result"]["files_content"]
    paths = options["cell_result"]["files_path"]

    contents.zip(paths).each do |content, path|
      Trailblazer::Generator::Output.new(path: path, content: content).save
    end
  end

  def generate_views!(options, params:, **)
    options_dup = params[:options].dup
    actions = params[:options]['actions'].dup
    if actions.match /index/i
      actions << ',item'
      options_dup['actions'] = actions
    end
    result = Trailblazer::Generator::Builder::View.(name: params[:name], options: options_dup)
    options["view_result"] = result["view_result"]
    true
  end

  private
    def generate_file(options, params:, action:)
      model = Trailblazer::Generator::Cell.build_model(
        name: params[:name], action: action
      )
      content = Cell.(model, params[:options])

      options["cell_result"]["files_content"] << content.show

      name = Trailblazer::Generator::Inflector.underscore(params[:name])
      path = File.join('app', 'concepts', name, 'cell', "#{action.downcase}.rb")

      options["cell_result"]["files_path"] << path
      return options["cell_result"]
    end
end
