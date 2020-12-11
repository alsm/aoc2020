class Day8
  @input = Array(Array(String)).new
  def initialize(f : String)
    @input = File.read_lines(f).map{|l| l.split}
  end

  def pute(code : Array(Array(String)))
    ops = Set(Int32).new
    acc = 0
    index = 0
    while !ops.includes?(index) && index < code.size
      ops << index
      case code[index][0]
      when "acc"
        acc += code[index][1].to_i
        index += 1
      when "nop"
        index += 1
      when "jmp"
        index += code[index][1].to_i
      end
    end
    {acc, index}
  end

  def part1
    pute(@input)
  end

  def part2
    @input.map_with_index{|v, i| v[0] == "jmp" || v[0] == "nop" ? i : nil}.compact.each do |i|
      code = @input.clone
      code[i][0] = code[i][0] == "jmp" ? "nop" : "jmp"
      acc, index = pute(code)
      return acc if index == code.size
    end
    
  end
end

d = Day8.new("day8.txt")
pp d.part1[0]
pp d.part2