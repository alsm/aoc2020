class Day11
  @input = Array(Array(Char)).new

  class Cell
    property kind : Char
    def initialize(@kind, @level : Int32)
    end

    def floor?
      @kind == '.'
    end

    def occupied?
      @kind == '#'
    end

    def next_state(neighbours : Array(Cell))
      case @kind
      when '#'
        neighbours.select{|n| n.occupied?}.size >= @level ? 'L' : '#'
      when 'L'
        neighbours.select{|n| n.occupied?}.size > 0 ? 'L' : '#'
      else
        '.'
      end
    end
  end

  class Grid
    @floor = Array(Array(Cell)).new
    @neighbours : Proc(Int32, Int32, Array(Cell))
    @width : Int32
    @height : Int32
    @vectors = [[0,1], [1,1], [1,0], [1,-1], [-1,0], [-1,-1], [0,-1], [-1, 1]]

    def initialize(floor : Array(Array(Char)), level : Int32)
      @width = floor[0].size
      @height = floor.size
      floor.each_with_index do |l,i|
        @floor << Array(Cell).new
        l.each do |c|
          @floor[i] << Cell.new(c, level)
        end
      end
      if level == 4
        @neighbours = ->neighbours1(Int32, Int32)
      else
        @neighbours = ->neighbours2(Int32, Int32)
      end
    end
  
    def in_bounds(x, y,)
      0 <= x < @width && 0 <= y < @height
    end
  
    def neighbours1(x, y)
      @vectors.compact_map{|n| nx, ny = n; in_bounds(nx+x, ny+y) ? @floor[ny+y][nx+x] : nil}
    end

    def neighbours2(x, y)
      @vectors.compact_map{|v| vx, vy = v; seat_from_vector(x, y, vx, vy)}
    end

    def seat_from_vector(x, y, vx, vy)
      x += vx
      y += vy
      while in_bounds(x, y)
        return @floor[y][x] if !@floor[y][x].floor?
        x += vx
        y += vy
      end
      nil
    end

    def iterate
      changes = Array(Tuple(Cell, Char)).new
      @floor.each_with_index do |l,i|
        l.each_with_index do |c,j|
          ns = c.next_state(@neighbours.call(j,i))
          changes << {c, ns} if ns != c.@kind
        end
      end
      changes.each{|e| c,s = e; c.kind = s}
      changes.size
    end

    def run
      while
        changes = iterate
        return @floor.flatten.select{|c| c.occupied?}.size if changes == 0
      end
    end
  end

  def initialize(f : String)
    File.read_lines(f).each_with_index do |l,i|
      @input << Array(Char).new
      l.chars.each_with_index{|c,j| @input[i] << c}
    end
  end

  def part1
    Grid.new(@input.dup, 4).run
  end

  def part2
    Grid.new(@input.dup, 5).run
  end
end

d = Day11.new("day11.txt")
pp d.part1
pp d.part2