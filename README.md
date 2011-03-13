Compass Magick
==============

Dynamic image generation for Compass using ChunkyPNG (no dependency on RMagick, hooray!)

Example
-------

A [Sassy Button](http://jaredhardy.com/sassy-buttons/) recreated in Compass Magick:  
[StanAngeloff.github.com/compass-magick/](http://stanangeloff.github.com/compass-magick/)

Installation
------------

There are no official releases or Gems available yet. You can grab the source code from Github and copy it to your local Compass project:

    mkdir -p $COMPASS_PROJECT/extensions
    git clone git://github.com/StanAngeloff/compass-magick.git $COMPASS_PROJECT/compass-magick

Learn more about [installing ad-hoc extensions in Compass](http://beta.compass-style.org/help/tutorials/extensions/).

Usage
-----

Once you have installed Compass Magick locally, you can start using it without including or importing any additional files. The framework is registered and available in all of your documents.

APIs
----

- `magick_canvas(canvas, *commands)`  
  `magick_canvas(data, *commands)`  
  `magick_canvas(url, *commands)`  
  `magick_canvas(path, *commands)`  
  `magick_canvas(width, height, *commands)`

  Creates a new Canvas and execute all commands on the instance. The resulting image is returned as a Base64 encoded Data URL.

  **Compass Magick** does not support saving files on disk at this time as the main focus is adding functionality before refining the APIs.

  **Example:**

      # Create a transparent canvas
      magick-canvas(320px, 200px)

- `magick_fill(type, x1 = nil, y1 = nil, x2 = nil, y2 = nil)`

  Fills the Canvas region with the given `type`. Supported types as:

    * Solid color
    * Linear gradient

  **Example:**

      # Fill using a solid type
      magick-canvas(320px, 200px, magick-fill(red))

      # Fill using a linear-gradient type
      magick-canvas(320px, 200px, magick-fill(magick-linear-gradient(red, green, blue)))

      # Fill canvas leaving a 10px edge
      magick-canvas(320px, 200px, magick-fill(blue, 10px, 10px, -10px, -10px))

- `magick_border(type, radius = nil, width = nil, top_left = nil, top_right = nil, bottom_right = nil, bottom_left = nil)`

  Draws a (rounded) border around the Canvas with the given width and fill `type`. Supported types as:

    * Solid color
    * Linear gradient.

  When `width` is not given, the border fills the entire image.

  **Example:**

      # Draw a 1px border
      magick-canvas(320px, 200px, magick-border(black, 0, 1px))

      # Draw a 10px rounded border filling the entire canvas
      magick-canvas(320px, 200px, magick-border(black, 10px))

- `magick_corners(radius, top_left = nil, top_right = nil, bottom_right = nil, bottom_left = nil)`

  Applies rounded corners around the Canvas. Can be used in combination with `magick-border` to create buttons.

  **Example:**

      magick-canvas(320px, 200px,
        magick-fill(black),
        magick-border(white, 10px, 1px),
        magick-corners(10px)
      )

- `magick_compose(overlay, x = nil, y = nil)`

  Composes one Canvas on top of another.

  **Example:**

      magick-canvas(320px, 200px,
        magick-fill(yellow),
        magick-compose(magick-canvas('icon.png'))
      )

- `magick_linear_gradient(angle, stops)`  
  `magick_linear_gradient(stops)`

  Creates a new linear gradient. Compass Magick supports gradients everywhere colors are accepted (e.g., borders). By default the angle of the gradient is 90deg. You can override this by specifying a number as the first argument to the function:

      magick-linear-gradient(45deg, red, green, blue)

  If you specify only color names, they will be positioned such as they are equally apart. You can override this behaviour by using color stops:

      magick-linear-gradient(
        magick-color-stop(25%, red),
        magick-color-stop(75%, blue)
      )

  Gradients cannot be used directly on the canvas. You can only apply them using another function:

      magick-fill(magick-linear-gradient(red, green, blue))

  **Example:**

      magick-canvas(320px, 200px,
        magick-fill(magick-linear-gradient(
          magick-color-stop(25%, yellow),
          magick-color-stop(50%, red)
        ))
      )

RDoc is [available for the entire project](http://stanangeloff.github.com/compass-magick/doc/frames.html).

Contribute
----------

Compass Magick is very much a work in progress (hence no official release yet).  
Documentation is sparse, speed is a major issue and there are probably a lot of bugs.

You can help by looking at any of the following areas (ordered by priority):

- [Optimizing the code](https://github.com/StanAngeloff/compass-magick/blob/master/lib/magick/canvas.rb#L76) as floating point math may not always be needed and too many object copies sucks
- [Writing tests](https://github.com/StanAngeloff/compass-magick/tree/master/spec) to make sure nothing breaks in new versions
- [Performing code reviews](https://github.com/StanAngeloff/compass-magick/tree/master/lib) since this is my very first Ruby project and I don't have any experience with the language so there are probably many st*oo*pid things in code
- [Improving RDoc](http://stanangeloff.github.com/compass-magick/doc/frames.html) because you can never have too much documentation
- [Adding new plugins](http://stanangeloff.github.com/compass-magick/doc/Compass/Magick/Plugins.html). Compass Magick [looks](https://github.com/StanAngeloff/compass-magick/blob/master/lib/magick.rb#L31) for Ruby files and imports those on startup
- [Submitting more examples](https://github.com/StanAngeloff/compass-magick/tree/gh-pages) to show off what Compass Magick can do
- [Opening issues](https://github.com/StanAngeloff/compass-magick/issues) for features you find missing or broken
- Porting over some of [CamanJS](http://camanjs.com/)' goodness, we all love visual effects

### Credits

I would like to thank [Willem van Bergen](http://twitter.com/#!/wvanbergen) for his great work on [ChunkyPNG](https://github.com/wvanbergen/chunky_png) which has been a major source of knowledge while working on the project.  
[Chris Eppstein](http://twitter.com/#!/chriseppstein) for [Compass](https://github.com/chriseppstein/compass) itself.  
The Ruby community for being awesome and welcoming a PHP stranger.