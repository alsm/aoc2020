class Day21
  @input : Array(Tuple(Array(String), Array(String)))
  @allergens = Hash(String, String).new
  def initialize(f : String)
    @input = File.read_lines(f).map{|l| l.gsub(/[\(\),]/, "").split(" contains ").map &.split(" ")}.map{|l| {l[0], l[1]}}
  end

  def part1
    alg = @input.flat_map(&.[1]).to_set
    while !alg.empty?
      alg.each do |a|
        ingredients = @input.select{|f| f[1].includes?(a)}
        matches = ingredients.flat_map(&.[0]).tally.select{|i,c| c == ingredients.size}.compact_map{|k,v| @allergens.values.includes?(k) ? nil : k}
        if matches.size == 1
          @allergens[a] = matches[0]
          alg.delete(a)
        end
      end
    end
    (@input.flat_map(&.[0]) - @allergens.values).size
  end

  def part2
    @allergens.keys.sort.map{|i| @allergens[i]}.join(",")
  end
end

d = Day21.new("day21.txt")
pp d.part1
pp d.part2