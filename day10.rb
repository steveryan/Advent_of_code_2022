data = File.read("data/day10.txt").lines.map(&:strip)

data = data.map do |line|
  if line == "noop"
    line = line
  else
    line = line.split(" ")[1].to_i
  end
end

data = data.reverse

def generate_cycle_map(data)
  x = 1
  cycle = 1
  cycle_map = {}
  while cycle <= 240
  instruction = data.pop
    # if cycle == 20 || cycle == 60 || cycle == 100 || cycle == 140 || cycle == 180 || cycle == 220
    #   p "x at cycle #{cycle}: #{x}"
    # end
    if instruction.is_a?(Integer)
      cycle_map[cycle] = x
      cycle_map[cycle + 1] = x
      cycle_map[cycle + 2] = x
      x += instruction
      cycle += 2
    else
      cycle_map[cycle] = x
      cycle += 1
    end
  end
  cycle_map
end

def part1(cycle_map)
  [cycle_map[20] * 20, cycle_map[60] * 60, cycle_map[100] * 100, cycle_map[140] * 140, cycle_map[180] * 180, cycle_map[220] * 220].sum
end

def part2(cycle_map)
  crt_array = []
  for i in 1..240
    if (cycle_map[i] - (i-1)%40).abs <= 1
      crt_array[i-1] = colorize('X', :bright_red)
    else
      crt_array[i-1] = ' '
    end
  end
  crt_arrays = crt_array.each_slice(40).to_a
  crt_arrays.each do |array|
    puts array.join
  end
end

def colorize(value, color)
  case color
  when :bright_red then "\e[1m\e[31m" + value.to_s + "\e[0m"
  else value.to_s
  end
end

cycle_map = generate_cycle_map(data)
p "Part 1: #{part1(cycle_map)}"
p "Part 2:"
part2(cycle_map)

