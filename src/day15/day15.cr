class Day15
  @input : Array(Int32)

  def initialize(f : String)
    @input = File.read(f).to_s.split(",").map{|c| c.to_i32}
  end

  def game(n : Int32)
    g = Array(Int32).new(n, -1)
    @input.each_with_index{|v,i| g[v] = i+1}
    last = 0
    (@input.size+1...n).each do |i|
      if g[last] == -1
        g[last], last = i, 0
      else
        g[last], last = i, i-g[last]
      end
    end
    last
  end

  def part1
    game(2020)
  end

  def part2
    game(30000000)
  end
end

d = Day15.new("day15.txt")
pp d.part1
pp d.part2