  class Day22
    @player1 : Array(Int64)
    @player2 : Array(Int64)
    def initialize(f : String)
      @player1, @player2 = File.read(f).split("\n\n").map{|l| l.split("\n")[1..].map &.to_i64}
    end

    def play_round(p1, p2)
      p1[0] > p2[0] ? (p1.rotate!; p1 << p2.shift) : (p2.rotate!; p2 << p1.shift)
    end

    def play_game(p1, p2)
      prev_rounds = Set(Tuple(Array(Int64), Array(Int64))).new
      until p1.empty? || p2.empty?
        return true if prev_rounds.includes?({p1,p2})
        prev_rounds << {p1.dup,p2.dup}
        if p1.size-1 >= p1[0] && p2.size-1 >= p2[0]
          play_game(p1[1..p1[0]].dup, p2[1..p2[0]].dup) ? (p1.rotate!; p1 << p2.shift) : (p2.rotate!; p2 << p1.shift)
        else
          play_round(p1,p2)
        end
      end
      p1.empty? ? false : true
    end

    def part1
      p1 = @player1.dup
      p2 = @player2.dup
      winner : Array(Int64)?
      until p1.empty? || p2.empty?
        winner = play_round(p1,p2)
      end
      if winner
        winner.zip(winner.size.downto(1)).map{|(a,b)| a*b}.sum
      end
    end

    def part2
      p1 = @player1.dup
      p2 = @player2.dup
      winner = play_game(p1, p2) ? p1 : p2
      winner.zip(winner.size.downto(1)).map{|(a,b)| a*b}.sum
    end
  end

  d = Day22.new("day22.txt")
  pp d.part2