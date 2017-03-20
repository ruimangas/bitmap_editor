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

  def draw_bucket(x, y, color, new_color, looked_neighbours = [])
    unseen_neighbours = neighbours_of(x, y).reject do |neighbour|
      looked_neighbours.include?(neighbour)
    end

    paint_unseen = unseen_neighbours.select { |y, x| @image[y-1][x-1] == color }.each do |y, x|
      @image[y-1][x-1] = new_color
    end

    looked_neighbours += paint_unseen

    paint_unseen.map do |y, x|
      draw_bucket(x, y, color, new_color, looked_neighbours)
    end
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

  def neighbours_of(x, y)
    neighbours = Array.new

    [y-1, y+1].each do |row|
      if row.between?(1, @height)
        neighbours << [row, x]
      end
    end

    [x-1, x+1].each do |column|
      if column.between?(1, @width)
        neighbours << [y, column]
      end
    end

    neighbours
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
