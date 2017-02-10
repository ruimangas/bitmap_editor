class BitmapEditor
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
    type, *args = input.split
    m = find_method(type)
    if commands_mapping.key?(m)
      method = commands_mapping.fetch(m)
      send(method, *args)
    else
      puts 'unrecognised command :('
    end
  end

  def create_bitmap(width, height)
  end

  def draw_pixel(x, y, c)
  end

  def draw_vertical(x, y1, y2, c)
  end

  def draw_horizontal(x1, x2, y, c)
  end

  def print_bitmat
  end

  def clear_table
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

  def commands_mapping
    {
      'I M N': 'create_bitmap' ,
      'L X Y C': 'draw_pixel',
      'V X Y1 Y2 C': 'draw_vertical',
      'H X1 X2 Y C': 'draw_horizontal',
      'C': 'clear_table',
      'S': 'print',
      'X': 'exit_console',
      '?': 'show_help'
    }
  end

  def find_method(type)
    keys.select do |cmds|
      cmds.first == type
    end.first.join(' ').to_sym
  end

  def keys
    commands_mapping.keys \
      .map(&:to_s)
      .map(&:split)
  end
end
