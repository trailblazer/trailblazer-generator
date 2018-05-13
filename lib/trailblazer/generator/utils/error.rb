module Trailblazer
  class Generator
    module Utils
      # Raise an error for source/exist/write issue
      class Error
        def initialize
          @pastel = Pastel.new
        end

        def source(context)
          abort(
            "\t#{@pastel.red("Error")}:\t#{Utils::Files.get_file_name(context).to_s.ljust(55, " ")} - No source file found"\
            "\n\t\tPlease create it or notify the developers\n\n"\
          )
        end

        def exist(context)
          abort("\t#{@pastel.red("Exist")}:\t#{context}\n\n")
        end

        def write(context)
          abort("\n\t#{@pastel.red("Error")}:\tWhile trying to (over)write #{context}\n\n")
        end

        def class_name(class_name)
          abort("\n\t#{@pastel.red("Error")}:\tYou provided an invalid class name - #{class_name}\n\n")
        end
      end
    end
  end
end
