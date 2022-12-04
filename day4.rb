data = File.read("data/day4.txt").lines.map(&:strip).map do |line|
  line.split(",").map do |pair|
    pair.split("-").map(&:to_i)
  end
end

def part1(data)
  overlapped = []
  data.each do |pair|
    if pair[0][0] >= pair[1][0] && pair[0][1] <= pair[1][1]
      overlapped << pair
    elsif pair[1][0] >= pair[0][0] && pair[1][1] <= pair[0][1]
      overlapped << pair
    end
  end
  overlapped
end

def part2(data)
  overlapped = []
  data.each do |pair|
    if pair[0][0] >= pair[1][0] && pair[0][1] <= pair[1][1]
      overlapped << pair
    elsif pair[1][0] >= pair[0][0] && pair[1][1] <= pair[0][1]
      overlapped << pair
    elsif pair[0][0] >= pair[1][0] && pair[0][0] <= pair[1][1]
      overlapped << pair
    elsif pair[0][1] >= pair[1][0] && pair[0][1] <= pair[1][1]
      overlapped << pair
    end
  end
  overlapped
end


p "Part 1: #{part1(data).length}"
p "Part 2: #{part2(data).length}"