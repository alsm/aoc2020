class Day17
  class Dimension
    property cubes : Set(Array(Int32))
    @vectors : Set(Array(Int32))

    def initialize(@cubes)
      @vectors = ([1,0,-1]*4).permutations(4).to_set
      @vectors.delete([0,0,0,0])
    end

    def neighbours(c : Array(Int32))
      points_around(c).select{|v| @cubes.includes?(v)}
    end

    def points_around(c : Array(Int32))
      x,y,z,w = c
      @vectors.map{|(x1,y1,z1,w1)| [x+x1, y+y1, z+z1, w+w1]}.to_set
    end

    def cycle
      deletes = Set(Array(Int32)).new
      adds = Set(Array(Int32)).new
      @cubes.reduce(Set(Array(Int32)).new){|acc,c| acc + points_around(c) + [c].to_set}.each do |c|
        case @cubes.includes?(c)
        when true
          s = neighbours(c).size
          deletes << c if !(s == 2 || s == 3)
        when false
          adds << c if neighbours(c).size == 3
        end
      end
      @cubes -= deletes
      @cubes += adds
    end
    
    def run(x)
      (1..x).each{|x| cycle; pp @cubes.size}
      @cubes.size
    end
  end

  def initialize(f : String)
    cubes = Set(Array(Int32)).new
    File.read_lines(f).each_with_index do |l,y|
      l.chars.each_with_index{|c,x| cubes << [x,y,0,0] if c == '#'} 
    end
    @d = Dimension.new(cubes)
  end
end

d = Day17.new("day17.txt")
d.@d.run(6)