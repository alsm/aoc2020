class Day19
  @rules = Hash(String,String).new
  @msgs : Array(String)
  def initialize(f : String)
    defs, @msgs = File.read(f).split("\n\n").map &.split("\n")
    defs.each do |d|
      i, r = d.split(": ")
      @rules[i] = r.gsub("\"", "")
    end
  end

  def part1
    r0 = "^#{@rules["0"]}$"
    while true
      rn = r0.scan(/\d+/)
      break if rn.size.zero?
      rn.each {|n| r0 = r0.gsub(/\b#{n[0]}\b/, "(#{@rules[n[0]]})") }
    end
    r0 = r0.gsub(" ", "")
    @msgs.select{|m| Regex.new(r0).matches?(m)}.size
  end

  def part2
    @rules["8"] = "42+"
    @rules["11"] = "(?<a>42 \\g<a>* 31)"
    r0 = "^#{@rules["0"]}$"
    while true
      rn = r0.scan /\d+/
      break if rn.size.zero?
      rn.each {|n| r0 = r0.gsub(/\b#{n[0]}\b/, "(#{@rules[n[0]]})") }
    end
    r0 = r0.gsub(" ", "")
    @msgs.select{|m| Regex.new(r0).matches?(m)}.size
  end
end

d = Day19.new("day19.txt")
pp d.part1
pp d.part2