class Trailblazer::Generator::Builder::View < Trailblazer::Operation
  class Cell < Trailblazer::Generator::Cell
  end

  step Trailblazer::Generator::Macro::ValidateClassName()
  step :generate_actions!
  step :create_files!
  failure Trailblazer::Generator::Macro::Failure()

  def generate_actions!(options, params:, **)
    actions = params[:options]['actions'].split(',')
    options["view_result"] = {"files_content" => [], "files_path" => []}
    actions.each do |action|
      options["view_result"] = generate_file(options, params: params, action: action)
    end
  end

  def create_files!(options, params:, **)
    debug = (params[:options]["debug"] ||= false)
    return true if debug

    contents = options["view_result"]["files_content"]
    paths = options["view_result"]["files_path"]

    contents.zip(paths).each do |content, path|
      Trailblazer::Generator::Output.new(path: path, content: content).save
    end
  end

  private
    def generate_file(options, params:, action:)
      model = Trailblazer::Generator::Cell.build_model(
        name: params[:name], action: action
      )
      content = Cell.(model, params[:options])

      options["view_result"]["files_content"] << content.show

      name = Trailblazer::Generator::Inflector.underscore(params[:name])
      path = File.join('app', 'concepts', name, 'view', "#{action.downcase}.erb")

      options["view_result"]["files_path"] << path

      return options["view_result"]
    end
end
