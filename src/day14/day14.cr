class Day14
  @mem = Hash(Int64,Int64).new

  def initialize(@f : String)
  end

  def apply_mask(v : Int64, m : Array(Char))
    new_v = Array(Char).new
    m.reverse.zip?(v.to_s(2).chars.reverse){|a,b| a == 'X' ? new_v << (b ? b : '0') : new_v << a}
    new_v.reverse.join.to_i64(2)
  end

  def apply_multi_mask(v : Int64, m : Array(Char))
    mul = m.select{|x| x == 'X'}.size
    (['0','1'] * mul).flatten.combinations(mul).uniq.map do |bitm|
      new_v = Array(Char).new
      m.reverse.zip?(v.to_s(2).chars.reverse){|a,b| a == '1' || a == 'X' ? new_v << a : new_v << (b ? b : '0')}
      new_v.map_with_index{|x,i| x == 'X' ? i : nil}.compact.each_with_index{|l,i| new_v[l] = bitm[i]}
      new_v.reverse.join.to_i64(2)
    end
  end

  def part1
    @mem = Hash(Int64,Int64).new
    mask = Array(Char).new
    File.read_lines(@f).each do |l|
      if l.starts_with?("mask = ")
        mask = l.sub(/mask = /, "").chars
      end
      if m = /mem\[(\d+)\] = (\d+)/.match(l)
        @mem[m[1].to_i64] = apply_mask(m[2].to_i64, mask) 
      end
    end
    @mem.values.sum
  end

  def part2
    @mem = Hash(Int64,Int64).new
    mask = Array(Char).new
    File.read_lines(@f).each do |l|
      if l.starts_with?("mask = ")
        mask = l.sub(/mask = /, "").chars
      end
      if m = /mem\[(\d+)\] = (\d+)/.match(l)
        apply_multi_mask(m[1].to_i64, mask).each{|l| @mem[l] = m[2].to_i64}
      end
    end
    @mem.values.sum
  end
end

d = Day14.new("day14.txt")
pp d.part1
pp d.part2