class Day13
  @time : Int64
  @buses : Array({dp: Int64, id: Int64})
  def initialize(f : String)
    input = File.read_lines(f)
    @time = input[0].to_i64
    @buses = input[1].split(",").map_with_index{|v, i| v.to_i64? ? {dp: i.to_i64, id: v.to_i64} : nil}.compact
  end

  class Stepper
    include Iterator(Int64)
    def initialize(@val : Int64, @step : Int64)
    end

    def next
      @val += @step
    end
  end

  def part1
    (@time..).each do |t|
      catch = @buses.select{|b| t % b[:id] == 0}
      return catch.first[:id] * (t - @time) if !catch.empty?
    end
  end
  
  def part2
    @buses[1..].reduce({@buses.first[:id], @buses.first[:id]}) do |acc, b|
      mul, step = acc.not_nil!
      {Stepper.new(mul.not_nil!, step).find{|x| (x + b[:dp]) % b[:id]== 0}, step*b[:id]}
    end
  end
end

d = Day13.new("day13.txt")
pp d.part1
pp d.part2[0]