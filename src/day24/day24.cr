class Day24
  @input : Array(Array(Array(Int32)))
  @grid = Hash(Array(Int32), Char).new('W')
  @dir_map = {"w" => [-1,1,0],
    "nw" => [0,1,-1],
    "sw" => [-1,0,1],
    "e" => [1,-1,0],
    "ne" => [1,0,-1],
    "se" => [0,-1,1]}
    
  def initialize(f : String)
    @input = File.read_lines(f).map{|l| (l.scan(/(sw|se|nw|ne|e|w)/).map &.[0]).map{|i| @dir_map[i]}}
  end

  def neighbours(p)
    around(p).map{|x| @grid[x]}
  end

  def around(p)
    @dir_map.values.map{|x| x.zip(p).map{|a,b| a+b}}
  end

  def cycle
    new_grid = Hash(Array(Int32), Char).new('W')
    (@grid.select{|k,v| v == 'B'}.keys).flat_map{|p| [p]+around(p)}.to_set.each do |p|
      case @grid[p]
      when 'W'
        new_grid[p] = 'B' if neighbours(p).count{|i| i == 'B'} == 2
      when 'B'
        new_grid[p] = 'B' if (1..2).includes?(neighbours(p).count{|i| i == 'B'})
      end
    end
    @grid = new_grid
  end

  def part1
    @input.each do |r|
      p = r.reduce([0,0,0]){|acc, s| acc.zip(s).map{|a,b| a+b}}
      @grid[p] = @grid[p] == 'W' ? 'B' : 'W'
    end
    @grid.count{|k,v| v == 'B'}
  end

  def part2
    100.times{ cycle }
    @grid.count{|k,v| v == 'B'}
  end
end

d = Day24.new("day24.txt")
pp d.part1
pp d.part2