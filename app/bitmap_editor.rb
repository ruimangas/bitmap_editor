class BitmapEditor
  attr_accessor :bitmap

  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp
      parse(input)
    end
  end

  private

  def parse(input)
    cmd, *params = input.split
    m = find_method(cmd)
    if cmds_mapping.key?(m)
      method = cmds_mapping.fetch(m)
      send(method, *params)
    else
      puts 'unrecognised command'
    end
  end

  def create_bitmap(width, height)
    @bitmap = Bitmap.new(width.to_i, height.to_i)
  end

  def draw_pixel(x, y, c)
    validate_bitmap!
    @bitmap.paint_pixel(x.to_i, y.to_i, c)
  end

  def draw_vertical(x, y1, y2, c)
    validate_bitmap!
    @bitmap.paint_column(x.to_i, y1.to_i, y2.to_i, c)
  end

  def draw_horizontal(x1, x2, y, c)
    validate_bitmap!
    @bitmap.paint_row(y.to_i, x1.to_i, x2.to_i, c)
  end

  def print_bitmat
    validate_bitmap!
    @bitmap.print
  end

  def clear_bitmap
    validate_bitmap!
    @bitmap.clear_image
  end

  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def show_help
    puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
  end

  def cmds_mapping
    {
      'I M N': 'create_bitmap' ,
      'L X Y C': 'draw_pixel',
      'V X Y1 Y2 C': 'draw_vertical',
      'H X1 X2 Y C': 'draw_horizontal',
      'C': 'clear_bitmap',
      'S': 'print_bitmat',
      'X': 'exit_console',
      '?': 'show_help'
    }
  end

  def validate_bitmap!
    fail ArgumentError, "Bitmap does not exist" unless @bitmap
  end

  def find_method(command)
    if cmd_exists?(command)
      cmds.select do |cmd|
        cmd.chars.first == command
      end.first.to_sym
    end
  end

  def cmd_exists?(type)
    cmds.map(&:chr).include?(type)
  end

  def cmds
    cmds_mapping.keys.map(&:to_s)
  end
end
