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
  def initialize(@edges : Hash(T, Array(T)))
  end

  def neighbours(l : T) : Array(T)
    @edges[l]
  end

  def bfs(start : T)
    frontier = Deque(T).new(1, start)
    reached = Set{start}
    while !frontier.empty?
      current = frontier.shift
      puts "  Visiting #{current}"
      self.neighbours(current).each do |x|
        if !reached.includes?(x)
          frontier << x
          reached << x
        end
      end
    end
  end
end

class GridGraph(T) < Graph(T)
  property walls : Array(T)
  def initialize(@width : Int32, @height : Int32)
    @walls = Array(T).new
  end

  def in_bounds(l : T)
    x,y = l
    0 <= x < @width && 0 <= y < @height
  end

  def passable(l : T)
    !@walls.includes?(l)
  end

  def neighbours(l : T) : Array(T)
    x,y = l
    [{x+1, y}, {x-1, y}, {x, y-1}, {x, y+1}].select{|p| in_bounds(p)}.select{|p| passable(p)}
  end

  def bfs(start : T, goal : T)
    frontier = Deque(T).new(1, start)
    came_from = Hash(T, T?).new
    came_from[start] = nil
    while !frontier.empty?
      current = frontier.shift
      pp current
      break if current == goal
      self.neighbours(current).each do |x|
        if !came_from.has_key?(x)
          frontier << x
          came_from[x] = current
        end
      end
    end
    came_from
  end
end

class WeightedGridGraph(T) < GridGraph(T)
  def initialize(w : Int32, h : Int32)
    super
    @weights = Hash(T, Float64).new
  end

  def cost(from : T, to : T)
    @weights.fetch(to, 1)
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

gr = WeightedGridGraph(Tuple(Int32, Int32)).new(30, 15)
gr.walls = [{21, 0}, {21, 1}, {21, 2}, {21, 3}, {21, 4}, {21, 5}, {21, 6},
            {22, 0}, {22, 1}, {22, 2}, {22, 3}, {22, 4}, {22, 5}, {22, 6},
            {3, 3}, {3, 4}, {3, 5}, {3, 6}, {3, 7}, {3, 8}, {3, 9}, {3, 10}, {3, 11},
            {4, 4}, {4, 4}, {4, 5}, {4, 6}, {4, 7}, {4, 8}, {4, 9}, {4, 10}, {4, 11},
            {13, 5}, {13, 6}, {13, 7}, {13, 8}, {13, 9}, {13, 10}, {13, 11}, {13, 12}, {13, 13}, {13, 14},
            {14, 5}, {14, 6}, {14, 7}, {14, 8}, {14, 9}, {14, 10}, {14, 11}, {14, 12}, {14, 13}, {14, 14}]

pp gr.bfs({8,7}, {17,2})