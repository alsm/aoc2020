class Day3
  @slope : Array(Array(Char))

  def initialize(f : String)
    @slope = File.read_lines(f).map { |l| l.strip.chars }
  end

  def part1(x : Int, y : Int)
    @slope.map_with_index{ |l, i| l[x*i//y % l.size] == '#' && i % y == 0 ? 1 : 0 }.sum
  end

  def part2(s : Array(Tuple(Int32, Int32)))
    s.map{ |e| x, y = e; part1(x,y)}.product(1_i64)
  end
end

d = Day3.new("day3.txt")
pp d.part1(3, 1)
pp d.part2([{1,1}, {3,1}, {5,1}, {7,1}, {1,2}])