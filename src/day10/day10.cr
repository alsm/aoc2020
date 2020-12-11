class Day10
  @input : Array(Int64)
  def initialize(f : String)
    @input = File.read_lines(f).map{|l| l.to_i64}.sort
  end

  def part1
    c = ([0] + @input).map_with_index{|v,i| (@input+[@input.last+3])[i]-v}.tally
    c[3] * c[1]
  end

  def part2
    multimap = {1 => 1, 2 => 2, 3 => 4, 4 => 7, 5 => 13, 6 => 24}
    ([0] + @input)
      .map_with_index{|v,i| (@input+[@input.last+3])[i]-v}
      .chunks{|x| x == 1}
      .compact_map{|t,v| multimap[v.size] if t}
      .product(1_i64)
  end

  def part22
    counts = Array(Int64).new(@input.last+4, 0_i64)
    counts[0] = 1
    (@input+[@input.last+3]).each do |x|
      counts[x] = (x-3..x-1).map{|i| counts[i]}.sum
    end
    counts[@input.last]
  end
end

d = Day10.new("day10.txt")
pp d.part1
# pp d.part2
pp d.part22