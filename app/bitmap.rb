require_relative 'helpers'
require_relative 'pixel'

class Bitmap
  include Helpers::Colors

  attr_reader :width, :height, :image
  attr_writer :image

  def initialize(width, height)
    @width = width
    @height = height
    @image = build_bitmap
  end

  def print
    image.each do |line|
      puts line.join(' ')
    end
  end

  def paint_pixel(x, y, color)
    pixel = Pixel.new(x, y)
    paint(pixel, color)
  end

  def paint_column(x, y1, y2, color)
    pixels = column(x, y1, y2)
    paint_line(pixels, color)
  end

  def paint_row(y, x1, x2, color)
    pixels = row(y, x1, x2)
    paint_line(pixels, color)
  end

  def clear_image
    @image = build_bitmap
  end

  private

  def paint(pixel, color)
    validate(pixel)
    x = pixel.x - 1
    y = pixel.y - 1
    @image[y][x] = color
  end

  def paint_line(pixels, color)
    pixels.each do |pixel|
      paint(pixel, color)
    end
  end

  def column(x, y1, y2)
    validate_line(y1, y2)

    (y1..y2).map do |y|
      Pixel.new(x, y)
    end
  end

  def row(y, x1, x2)
    validate_line(x1, x2)

    (x1..x2).map do |x|
      Pixel.new(x, y)
    end
  end

  def build_bitmap
    Array.new(@height) { Array.new(@width, WHITE) }
  end

  def validate(pixel)
    unless pixel.x.between?(1, @width) && pixel.y.between?(1, @height)
      fail ArgumentError, 'Pixel position is not valid'
    end
  end

  def validate_line(p1, p2)
    fail ArgumentError, 'Invalid line' if p1 > p2
  end
end
