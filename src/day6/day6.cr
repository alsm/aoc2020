class Day6
  @input = Array(Array(String)).new
  def initialize(f : String)
    @input = File.read_lines(f)
      .chunk {|l| l == ""}
      .map{|(t, l)| l.first.empty? ? nil : l}
      .to_a.compact
  end

  def part1
    @input.map{|q| q.join("").chars.uniq.size}.sum
  end

  def part2
    @input.map{|q| q.map{|e| e.chars}.reduce{|s,o| s &= o}.size}.sum
  end
end

d = Day6.new("day6.txt")
pp d.part1
pp d.part2