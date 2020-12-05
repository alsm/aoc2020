class Day5
  @seats : Array(Int32)
  def initialize(f : String)
    @seats = File.read_lines(f).map{|l| l.tr("FBRL", "0110").to_i(2)}
  end

  def part1
    @seats.max
  end

  def part2
    (Range.new(@seats.min, @seats.max).to_a - @seats).first
  end
end

d = Day5.new("day5.txt")
pp d.part1
pp d.part2