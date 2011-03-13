module Compass::Magick
  module Functions
    # Methods for performing various visual effects on a
    # {Compass::Magick::Canvas}, e.g., fade, desaturate, etc.
    module Effects
      extend self

      # Adjusts the intensity of a color by changing its alpha by a given
      # value.
      #
      # @param [Sass::Script::Number] adjust Fade value as a float between
      #   0.0 and 1.0.
      # @return {Effect} A command which applies the fade to the canvas.
      def fade(adjust = nil)
        Compass::Magick::Utils.assert_type 'adjust', adjust, Sass::Script::Number
        fade_adjust = 255 - (255 * Compass::Magick::Utils.value_of(adjust, 1.0, 0.5)).to_i
        Effect.new { |pixel| ChunkyPNG::Color.fade(pixel, fade_adjust) }
      end

      # Adjusts the brightness of a color by changing its [R, G, B]
      # components by a given value.
      #
      # Copyright (c) 2010, Ryan LeFevre
      # http://www.camanjs.com
      #
      # @param [Sass::Script::Number] adjust Brightness value as a float
      #   between -1.0 and 1.0.
      # @return {Effect} A command which applies the Brightness to the
      #   canvas.
      def brightness(adjust = nil)
        Compass::Magick::Utils.assert_type 'adjust', adjust, Sass::Script::Number
        brightness_adjust = (255 * Compass::Magick::Utils.value_of(adjust, 1.0, 0.5)).to_i
        Effect.new do |pixel|
          ChunkyPNG::Color.rgba(
            [0, [ChunkyPNG::Color.r(pixel) + brightness_adjust, 255].min].max,
            [0, [ChunkyPNG::Color.g(pixel) + brightness_adjust, 255].min].max,
            [0, [ChunkyPNG::Color.b(pixel) + brightness_adjust, 255].min].max,
            ChunkyPNG::Color.a(pixel)
          )
        end
      end
    end
  end
end
