class Trailblazer::Generator::Inflector
  # Converts strings to UpperCamelCase.
  # If the +uppercase_first_letter+ parameter is set to false, then produces
  # lowerCamelCase.
  #
  # Also converts '/' to '::' which is useful for converting
  # paths to namespaces.
  #
  #   camelize('trail_blazer')                # => "TrailBlazer"
  #   camelize('trail_blazer/operation')      # => "TrailBlazer::Operation"
  #
  # As a rule of thumb you can think of +camelize+ as the inverse of
  # #underscore, though there are cases where that does not hold:
  #
  #   camelize(underscore('SSLError'))        # => "SslError"
  def self.camelize(term)
    string = term.to_s
    string.gsub!(/\/([a-zA-Z])/) { |m| "::#{$1.upcase}" }
    string.gsub!(/_([a-zA-Z])/) { |m| "#{$1.upcase}" }
    string.gsub!(/^([a-zA-Z])/) { |m| "#{$1.upcase}" }
    string.gsub!("/".freeze, "::".freeze)
    string
  end

  # Makes an underscored, lowercase form from the expression in the string.
  #
  # Changes '::' to '/' to convert namespaces to paths.
  #
  #   underscore('TrailBlazer')            # => "trail_blazer"
  #   underscore('TrailBlazer::Operation') # => "trail_blazer/operation"
  #
  # As a rule of thumb you can think of +underscore+ as the inverse of
  # #camelize, though there are cases where that does not hold:
  #
  #   camelize(underscore('SSLError'))  # => "SslError"
  def self.underscore(camel_cased_word)
    return camel_cased_word unless /[A-Z-]|::/.match?(camel_cased_word)
    word = camel_cased_word.to_s.gsub("::".freeze, "/".freeze)
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
    word.tr!("-".freeze, "_".freeze)
    word.downcase!
    word
  end
end
