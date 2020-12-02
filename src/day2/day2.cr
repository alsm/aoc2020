class Day2
  @input = Hash(Rule, String).new

  class Rule
    def initialize(@first : Int32, @second : Int32, @char : Char)
    end
  end

  def initialize(f : String)
    File.each_line(f) do |l|
      rule, password = l.split(": ")
      if m = /(\d+)-(\d+) (.)/.match(rule)
        @input[Rule.new(m[1].to_i32, m[2].to_i32, m[3][0])] = password
      end
    end
  end

  def part1
    @input.count { |k,v|
      v.count(k.@char) >= k.@first && v.count(k.@char) <= k.@second
    }
  end

  def part2
    @input.count { |k,v|
      v[k.@first-1] == k.@char && !(v[k.@second-1] == k.@char) || 
      !(v[k.@first-1] == k.@char) && v[k.@second-1] == k.@char
    }
  end
end

d = Day2.new("day2.txt")
pp d.part1()
pp d.part2()