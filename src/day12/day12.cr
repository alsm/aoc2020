class Day12
  class Boat
    @angle = 'E'
    @x = 0
    @y = 0
    @wx = 10
    @wy = 1
    @directions : Array(Char) = ['N', 'E', 'S', 'W']
    
    def initialize
    end

    def rotate_waypoint(a : Int32)
      @wx, @wy = [{@wx, @wy}, {@wy, -1 * @wx}, {-1 * @wx, -1 * @wy}, {-1 * @wy, @wx}][((360+a) % 360) // 90]
    end

    def move_waypoint(dir : Char, mag : Int32)
      @wx, @wy = {'N' => {@wx, @wy+mag}, 'E' => {@wx+mag, @wy}, 'S' => {@wx, @wy - mag}, 'W' => {@wx - mag, @wy}}[dir] if "NSEW".includes?(dir)
      @x, @y = {@x + @wx * mag, @y + @wy * mag} if dir == 'F'
      rotate_waypoint(mag * {'R' => 1, 'L' => -1}[dir]) if "RL".includes?(dir)
    end

    def move(dir : Char, mag : Int32)
      if "RL".includes?(dir)
        @angle = {'R' => @directions[(@directions.index(@angle).not_nil! + mag // 90) % 4],
                 'L' => @directions[(@directions.index(@angle).not_nil! - mag // 90) % 4]}[dir]
        return
      end
      dir = @angle if dir == 'F'
      @x, @y = {'N' => {@x, @y+mag}, 'E' => {@x+mag, @y}, 'S' => {@x, @y - mag}, 'W' => {@x - mag, @y}}[dir]
    end
  end

  @input = Array(Tuple(Char, Int32)).new

  def initialize(f : String)
    @input = File.read_lines(f).map{|l| {l[0], l[1..].to_i32}}
  end

  def part1
    b = Boat.new
    @input.each{|c| dir, mag = c; b.move(dir, mag)}
    b.@x.abs + b.@y.abs
  end

  def part2
    b = Boat.new
    @input.each{|c| dir, mag = c; b.move_waypoint(dir, mag)}
    b.@x.abs + b.@y.abs
  end
end

d = Day12.new("day12.txt")
pp d.part1
pp d.part2