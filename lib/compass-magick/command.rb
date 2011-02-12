module Compass::Magick
  class Command < Sass::Script::Literal
    def invoke(image)
      raise NotImplementedError.new("#{self.class} must implement #invoke")
    end
  end
end

require 'compass-magick/commands/erase'
