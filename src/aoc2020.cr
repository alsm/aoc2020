# TODO: Write documentation for `Aoc2020`
def read_to_ints(f) : Array(Int64)
  File.read_lines(f).map { |i| i.to_i64() }
end

class Map
  @nodes = Set(Tuple(Int32, Int32)).new

  def initialize(m : Array(String), wall : Char)
    m.each_with_index do |l, i|
      l.chars.each_with_index do |c, j|
        if c != wall
          @nodes.add({j, i})
        end
      end
    end
  end

  def neighbours(n : Tuple(Int32, Int32))
    [{1, 0}, {0, 1}, {-1, 0}, {0, -1}].map { |(x,y)| 
      neighbour = {n[0] + x, n[1]+y}
      @nodes.includes?(neighbour) ? neighbour : nil
    }.compact
  end
end

abstract class Graph(T)
  abstract def neighbours(l : T) : Array(T)
end

class NodeGraph(T) < Graph(T)
  @edges = Hash(T, Array(T)).new

  def initialize(@edges)
  end

  def neighbours(l : T) : Array(T)
    @edges[l]
  end
end

def bfs(g : Graph, start : Char)
  frontier = Deque(Char).new(1, start)
  reached = Set{start}
  while !frontier.empty?
    current = frontier.shift
    puts "  Visiting #{current}"
    g.neighbours(current).each do |x|
      if !reached.includes?(x)
        frontier << x
        reached << x
      end
    end
  end
end

# g = Map.new(File.read_lines("test_map.txt"), '#')
# pp g.@nodes.size

g = NodeGraph(Char).new({
  'A' => ['B'],
  'B' => ['C'],
  'C' => ['B', 'D', 'F'],
  'D' => ['C', 'E'],
  'E' => ['F'],
  'F' => [] of Char,
})
pp bfs(g, 'A')