class Day16
  @rules = Hash(String,Array(Int32)).new
  @n_tickets = Array(Array(Int32)).new
  @my_ticket = Array(Int32).new
  def initialize(f : String)
    inputs = File.read_lines(f).chunk{|l| l == ""}.compact_map{|(t,l)| t ? nil : l}.to_a
    inputs[0].each do |i|
      parts = i.split(": ")
      ranges = parts[1].split(" or ").reduce(Array(Int32).new){|acc,r| sr = r.split("-"); acc + (sr[0].to_i32..sr[1].to_i32).to_a}
      @rules[parts[0]] = ranges
    end
    @n_tickets = inputs[2][1..].map{|t| t.split(",").map &.to_i32}
    @my_ticket = inputs[1][1].split(",").map &.to_i32
  end

  def part1
    @n_tickets.flatten.select{|v| !@rules.values.flatten.includes?(v)}
  end

  def part2
    rules = @rules.dup
    decoder = Hash(String,Int32).new
    invalid = part1
    v_tickets = @n_tickets.select{|t| t.size == (t - invalid).size}.transpose
    while rules.size > 0
      fields = Hash(String,Int32).new(0)
      mapping = Hash(String,Int32).new
      rules.each do |r_name, range|
        v_tickets.each_with_index do |field, i|
          {fields[r_name] += 1, mapping[r_name] = i} if field.reduce(true){|acc, v| acc & range.includes?(v)}
        end
      end
      entry = (fields.invert)[1]
      decoder[entry] = mapping[entry]
      v_tickets[decoder[entry]] = [Int32::MAX]
      rules.delete(entry)
    end
    @rules.keys.select{|n| n.starts_with?("departure")}.map{|f| @my_ticket[decoder[f]]}
  end
end

d = Day16.new("day16.txt")
pp d.part1.sum
pp d.part2.product(1_i64)
