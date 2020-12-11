class Day11
  @input = Hash(Tuple(Int32,Int32), Char).new

  class Grid
    @floor : Hash(Tuple(Int32,Int32), Char)
    @width : Int32
    @height : Int32

    def initialize(@floor : Hash(Tuple(Int32,Int32), Char), @occupied : Int32, @alt : Bool)
      @width = @floor.keys.map{|x,y| x}.max
      @height = @floor.keys.map{|x,y| y}.max
    end
  
    def in_bounds(l : Tuple(Int32, Int32))
      x,y = l
      0 <= x <= @width && 0 <= y <= @height
    end
  
    def is_floor(l : Tuple(Int32, Int32))
      @floor[l] == '.'
    end

    def is_occupied(l : Tuple(Int32, Int32))
      @floor[l] == '#'
    end
  
    def neighbours(l : Tuple(Int32, Int32))
      return neighbours2(l) if @alt
      x,y = l
      [{x+1, y}, {x-1, y}, {x, y-1}, {x, y+1}, {x+1, y+1}, {x-1, y-1}, {x+1, y-1}, {x-1, y+1}]
        .select{|p| in_bounds(p) && !is_floor(p)}
    end

    def neighbours2(l : Tuple(Int32, Int32))
      x,y = l
      [{1, 0}, {-1, 0}, {0, -1}, {0, 1}, {1, 1}, {-1, -1}, {1, -1}, {-1, 1}]
        .compact_map{|v| s = seat_from_vector(l, v); in_bounds(s) && !is_floor(s) ? s : nil}
    end

    def seat_from_vector(l : Tuple(Int32, Int32), v : Tuple(Int32, Int32))
      new_l = {l[0]+v[0], l[1]+v[1]}
      while in_bounds(new_l)
        return new_l if !is_floor(new_l)
        new_l = {new_l[0]+v[0], new_l[1]+v[1]}
      end
      new_l
    end

    def transform(l : Tuple(Int32, Int32))
      {'.' => '.',
       'L' => neighbours(l).select{|s| is_occupied(s)}.size > 0 ? 'L' : '#',
       '#' => neighbours(l).select{|s| is_occupied(s)}.size >= @occupied ? 'L' : '#'}[@floor[l]]
    end

    def iterate
      new_floor = Hash(Tuple(Int32,Int32), Char).new
      @floor.keys.each{|k| new_floor[k]=transform(k).not_nil!}
      new_floor
    end

    def run
      while
        new_floor = iterate
        return @floor.values.select{|s| s == '#'}.size if @floor.values == new_floor.values
        @floor = new_floor
      end
    end
  end

  def initialize(f : String)
    File.read_lines(f).each_with_index do |l,i|
      l.chars.each_with_index{|c,j| @input[{i,j}] = c}
    end
  end

  def part1
    Grid.new(@input.dup, 4, false).run
  end

  def part2
    Grid.new(@input.dup, 5, true).run
  end
end

d = Day11.new("day11.txt")
pp d.part1
pp d.part2