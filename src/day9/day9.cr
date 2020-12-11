class Day9
  @input : Array(Int64)
  def initialize(f : String)
    @input = File.read_lines(f).map{|l| l.to_i64}
  end

  def part1
    @input.each_cons(26) do |s|
      i = s.pop
      sums = s.combinations(2).map{|(a,b)| a + b}
      return i if !sums.includes?(i)
    end
  end

  def part2
    t = part1.not_nil!
    @input.each_index do |i|
      (1..).each do |j|
        v = @input[i..i+j]
        return v.min + v.max if v.sum == t
        break if t < v.sum
      end
    end
  end
end

d = Day9.new("day9.txt")
pp d.part1
pp d.part2