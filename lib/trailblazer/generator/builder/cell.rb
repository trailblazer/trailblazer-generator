class Trailblazer::Generator::Builder::Cell < Trailblazer::Operation
  class Cell < Trailblazer::Generator::Cell
  end

  step Trailblazer::Generator::Macro::ValidateClassName()
  step :generate_actions!
  step :create_files!
  step :generate_views!
  failure Trailblazer::Generator::Macro::Failure()

  def generate_actions!(options, params:)
    actions = params[:options]['actions'].split(',')
    params["cell_result"] = {"files_content" => [], "files_path" => []}
    actions.each do |action|
      params = generate_file(options, params: params, action: action)
      params = generate_file(options, params: params, action: 'item') if action == 'Index'
    end
  end

  def create_files!(options, params:)
    debug = (params[:options]["debug"] ||= false)
    return true if debug

    contents = params["cell_result"]["files_content"]
    paths = params["cell_result"]["files_path"]

    contents.zip(paths).each do |content, path|
      Trailblazer::Generator::Output.new(path: path, content: content).save
    end
  end

  def generate_views!(options, params:)
    options_dup = params[:options].dup
    actions = params[:options]['actions'].dup
    if actions.match /index/i
      actions << ',item'
      options_dup['actions'] = actions
    end
    result = Trailblazer::Generator::Builder::View.(name: params[:name], options: options_dup)
    params["view_result"] = result["params"]["view_result"]
    true
  end

  private
    def generate_file(options, params:, action:)
      model = Trailblazer::Generator::Cell.build_model(
        name: params[:name], action: action
      )
      content = Cell.(model, params[:options])

      params["cell_result"]["files_content"] << content.show

      name = Trailblazer::Generator::Inflector.underscore(params[:name])
      path = File.join('app', 'concepts', name, 'cell', "#{action.downcase}.rb")

      params["cell_result"]["files_path"] << path
      return params
    end
end
