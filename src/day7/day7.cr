class Day7
  @input = Hash(String, Hash(String, Int32)).new
  def initialize(f : String)
    File.read_lines(f).each do |l|
      holds, bags = l.sub(/ (bags|bag)/, "").split(" contain ")
      @input[holds] = Hash(String, Int32).new if !@input.has_key?(holds)
      bags.split(", ").each do |b|
        if m = /(\d) (\w+\s\w+)/.match(b)
          @input[holds][m[2]] = m[1].to_i
        end
      end
    end
  end

  def find(b : String, c : String)
    @input[c].reduce(false){|acc, (k,v)| acc ||= (k == b || find(b, k))}
  end

  def part1
    @input.map{|k,v| find("shiny gold", k) ? 1 : 0 }.sum
  end

  def number_contains(b : String, n : Int32)
    @input[b].empty? ? n : @input[b].map{|k,v| x = n * number_contains(k, v).as(Int32)}.sum + n
  end

  def part2
    number_contains("shiny gold", 1) - 1
  end
end

d = Day7.new("day7.txt")
pp d.part1
pp d.part2