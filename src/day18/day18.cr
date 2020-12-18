class Day18
  class Shunt
    @part2 = false
    def initialize(@input : Array(Char), @part2)
    end

    def unwind(num, oper)
      while !oper.empty? && oper.last != '('
        a, b = num.pop, num.pop
        num << @ops[oper.pop].call(a,b)
      end
    end

    def unwind2(num, oper, op)
      while !oper.empty? && oper.last != '(' && op == '*' && oper.last == '+'
        a = num.pop
        b = num.pop
        num << @ops[oper.pop].call(a,b)
      end
    end

    def eval
      num = Array(Int64).new
      oper = Array(Char).new
      while !@input.empty?
        v = @input.shift
        case
        when v.number?
          num << v.to_i64
        when v == '('
          oper << v
        when v == ')'
          unwind(num, oper)
          oper.pop
        else
          @part2 ? unwind2(num, oper, v) : unwind(num, oper)
          oper << v
        end
      end
      unwind(num, oper)
      num.first
    end

    @ops : Hash(Char,Proc(Int64,Int64,Int64)) = {
      '+' => ->(x : Int64, y : Int64) { x + y },
      '*' => ->(x : Int64, y : Int64) { x * y } }
  end

  def initialize(@f : String)
  end

  def part1
    File.read_lines(@f).map{|l| l.gsub(" ", "").chars}.map{|s| Shunt.new(s, false).eval}.sum
  end

  def part2
    File.read_lines(@f).map{|l| l.gsub(" ", "").chars}.map{|s| Shunt.new(s, true).eval}.sum
  end
end

d = Day18.new("day18.txt")
pp d.part1
pp d.part2