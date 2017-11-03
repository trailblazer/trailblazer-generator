module Trailblazer
  module Generator
    class Generate < Thor
      desc "cell NAME", "Generates cell file"
      long_desc <<-CELL_LONG_DESC

      `generate cell` generate cell and view file

      Actions Available:
        * new
        * show
        * index (will generate item as well)
        * edit
        * generic (if name doesn't match above, is generic)

      Template Engine for view:
        * default => erb

      Examples:
        `generate cell BlogPost --actions index,foo --template-engine slim`

        Will generate an index, item and foo cell files and the corrisponding template using slim

      CELL_LONG_DESC
      options actions: :required
      option :template_engine, default: "erb"
      def cell(name)
        Trailblazer::Generator::Builder::Cell.(name: name, options: options)
      end
    end
  end
end
