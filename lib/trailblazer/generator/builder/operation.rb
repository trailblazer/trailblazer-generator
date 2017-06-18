class Trailblazer::Generator::Builder::Operation < Trailblazer::Operation
  class Cell < Trailblazer::Generator::Cell
  end

  step Trailblazer::Generator::Macro::ValidateClassName()
  step :generate_file!
  step Trailblazer::Generator::Macro::Output()
  failure Trailblazer::Generator::Macro::Failure()

  def generate_file!(options, params:)
    options['content'] = Cell.(params[:name], params[:options])

    name = Trailblazer::Generator::Inflector.underscore(params[:name])
    options['path'] = File.join('app', 'concepts', name, 'operation', 'create.rb')
  end
end
