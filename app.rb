require "sinatra/base"
require "sinatra/assetpack"
require "compass"
require "compass-h5bp"
require "sinatra/support"
require "mustache/sinatra"
require "rmagick"

# Heroku reload.

class App < Sinatra::Base
  base = File.dirname(__FILE__)
  set :root, base

  register Sinatra::AssetPack
  register Sinatra::CompassSupport
  register Mustache::Sinatra

  set :sass, Compass.sass_engine_options
  set :sass, { :load_paths => sass[:load_paths] + [ "#{base}/app/css" ] }

  assets do
    serve '/js',    from: 'app/js'
    serve '/css',   from: 'app/css'
    serve '/img',   from: 'app/img'

    css :app_css, [ '/css/*.css' ]
    js :app_js, [
      '/js/*.js',
      '/js/vendor/jquery-1.9.1.min.js',
    ]
    js :app_js_modernizr, [ '/js/vendor/modernizr-2.6.2.min.js' ]

    # Heroku doesn't like this call but assets end up minified anyway.
    # Left them in in for reference.
    #css_compression :sass
    #js_compression  :jsmin
  end

  require "#{base}/app/helpers"
  require "#{base}/app/views/layout"

  set :mustache, {
    :templates => "#{base}/app/templates",
    :views => "#{base}/app/views",
    :namespace => App
  }

  before do
    @css = css :app_css
    @js  = js  :app_js
    @js_modernizr = js :app_js_modernizr
  end

  helpers do
    TOP_N = 10 # Number of swatches
     
    # Create a 1-row image that has a column for every color in the quantized
    # image. The columns are sorted decreasing frequency of appearance in the
    # quantized image.
    def sort_by_decreasing_frequency(img)
      hist = img.color_histogram
      # sort by decreasing frequency
      sorted = hist.keys.sort_by {|p| -hist[p]}
      new_img = Magick::Image.new(hist.size, 1)
      new_img.store_pixels(0, 0, hist.size, 1, sorted)
    end
     
    def get_pix(img)
      palette = Magick::ImageList.new
      pixels = img.get_pixels(0, 0, img.columns, 1)
    end
  end

  # Function allows both get / post.
  def self.get_or_post(path, opts={}, &block)
    get(path, opts, &block)
    post(path, opts, &block)
  end   

  get '/' do
    @page_title = "Colours"

    #the_image = "http://distilleryimage2.ak.instagram.com/2325f9b6f3ca11e287d022000a1fc4f9_7.jpg"
    the_image = params[:img]
    @the_image = the_image

    original = Magick::Image.read(the_image).first
     
    # reduce number of colors
    quantized = original.quantize(TOP_N, Magick::RGBColorspace)
     
    # Create an image that has 1 pixel for each of the TOP_N colors.
    normal = sort_by_decreasing_frequency(quantized)

    the_colours = get_pix(normal)
    arr_colours = Array.new

    the_colours.each do |p|
      colour = p.to_color(Magick::AllCompliance, false, 8, true)
      arr_colours.push(colour)    
    end

    @the_colours = arr_colours

    mustache :index
  end
end