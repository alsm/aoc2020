class Day1
    @input : Array(Int64)

    def initialize(f : String)
        @input = File.read_lines(f).map { |i| i.to_i64() }
    end

    def part1()
        @input.combinations(2).select { |i| i.sum == 2020 }.first.product
    end

    def part2()
        @input.combinations(3).select { |i| i.sum == 2020 }.first.product
    end

end

d = Day1.new("day1.txt")
pp d.part1()
pp d.part2()
