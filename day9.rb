require 'set'
data = File.read("data/day9.txt").lines.map(&:strip).map(&:split).map { |x| [x[0], x[1].to_i] }

def part1(data)
  visited = Set.new
  head_position = [0, 0]
  tail_position = [0, 0]
  data.each do |x|
    num_steps = x[1]
    direction = x[0]
    num_steps.times do
      case x[0]
      when "R"
        head_position[1] += 1
      when "L"
        head_position[1] -= 1
      when "U"
        head_position[0] += 1
      when "D"
        head_position[0] -= 1
      end

      if !touching?(head_position, tail_position)
        tail_position = move_tail(head_position, tail_position)
      end

      visited << tail_position
    end
  end
  p "Part 1: #{visited.size}"
end

def part2(data)
  visited = Set.new
  head_position = [0, 0]
  knots = {}
  (1..9).each do |x|
    knots[x] = [0, 0]
  end
  
  data.each do |x|
    num_steps = x[1]
    direction = x[0]
    num_steps.times do
      case x[0]
      when "R"
        head_position[1] += 1
      when "L"
        head_position[1] -= 1
      when "U"
        head_position[0] += 1
      when "D"
        head_position[0] -= 1
      end

      knots.each do |k, v|
        if k == 1
          leader = head_position
        else
          leader = knots[k - 1]
        end
        follower = knots[k]
        if !touching?(leader, follower)
          knots[k] = move_tail(leader, follower)
        end
      end

      visited << knots[9]
    end
  end
  p "Part 2: #{visited.size}"
end

def touching?(head, tail)
  return true if head[0] == tail[0] && head[1] == tail[1]
  if head[0] == tail[0]
    return true if (head[1] - tail[1]).abs == 1
  elsif head[1] == tail[1]
    return true if (head[0] - tail[0]).abs == 1
  elsif (head[0] - tail[0]).abs == 1 && (head[1] - tail[1]).abs == 1
    return true
  end
  return false
end

def move_tail(head, tail)
  if (head[0] - tail[0]) > 0 && (head[1] - tail[1]) > 0
    tail = [tail[0] + 1, tail[1] + 1]
  elsif (head[0] - tail[0]) > 0 && (head[1] - tail[1]) < 0
    tail = [tail[0] + 1, tail[1] - 1]
  elsif (head[0] - tail[0]) < 0 && (head[1] - tail[1]) > 0
    tail = [tail[0] - 1, tail[1] + 1]
  elsif (head[0] - tail[0]) < 0 && (head[1] - tail[1]) < 0
    tail = [tail[0] - 1, tail[1] - 1]
  elsif (head[0] - tail[0]) > 1
    tail = [tail[0] + 1, tail[1]]
  elsif (head[0] - tail[0]) < -1
    tail = [tail[0] - 1, tail[1]]
  elsif (head[1] - tail[1]) > 1
    tail = [tail[0], tail[1] + 1]
  elsif (head[1] - tail[1]) < -1
    tail = [tail[0], tail[1] - 1]
  else
    raise "error"
  end
end

part1(data)
part2(data)