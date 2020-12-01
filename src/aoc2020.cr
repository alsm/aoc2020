# TODO: Write documentation for `Aoc2020`
def read_to_ints(f) : Array(Int64)
  File.read_lines(f).map { |i| i.to_i64() }
end

