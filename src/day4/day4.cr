class Day4
  @input = Array(Hash(String, String)).new
  def initialize(f : String)
    File.read_lines(f)
      .chunk {|l| l == ""}
      .map{|(t, l)| l.join(" ")}
      .select{|l| !l.empty?}
      .map{|l| i = Hash(String, String).new; l.split(" ").each {|e| k,v = e.split(":"); i[k]=v}; i}
      .each{|e| @input << e}
  end

  def part1
    @input.count{|e| e.size == 8 || (e.size == 7 && !e.has_key?("cid"))}
  end

  def validate_number(v : String, lo : Int32, hi : Int32)
    v.to_i? && v.to_i >= lo && v.to_i <= hi
  end

  def validate_height(v : String)
    h = /(\d+)(in|cm)/.match(v).try &.[1]
    case t = /(\d+)(in|cm)/.match(v).try &.[2]
    when "cm"
      h && h.to_i? && h.to_i >= 150 && h.to_i <= 193
    when "in"
      h && h.to_i? && h.to_i >= 59 && h.to_i <= 76
    else
      false
    end
  end

  def part2
    eyes = Set{"amb", "blu", "brn", "gry", "grn", "hzl", "oth"}
    keys = Set{"byr","iyr","eyr","hgt","hcl","ecl","pid"}
    @input.map!{|e| e.delete("cid"); e}.select{|e| e.size == 7}.select{|e|
      validate_number(e["byr"], 1920, 2002) && validate_number(e["iyr"], 2010, 2020) &&
      validate_number(e["eyr"], 2020, 2030) && validate_height(e["hgt"]) && 
      e["hcl"].matches?(/#[a-z0-9]{6}/) && eyes.includes?(e["ecl"]) && e["pid"].match(/^\d{9}$/)
    }.size
  end
end

d = Day4.new("day4.txt")
pp d.part1()
pp d.part2()