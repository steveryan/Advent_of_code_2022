data = File.read("data/day2.txt").lines.map(&:strip).map(&:split)
p data

def part1(data)
  points = 0
  data.each do |game|
    case  game[1]
    when "X"
      points += 1
    when "Y"
      points += 2
    when "Z"
      points += 3
    end
    points += score_game(game)
  end
  points
end

def part2(data)
  points = 0
  data.each do |game|
    points += points_from_game(game)
  end
  points
end

def score_game(game)
  return 6 if game[0] == "A" && game[1] == "Y"
  return 6 if game[0] == "B" && game[1] == "Z"
  return 6 if game[0] == "C" && game[1] == "X"
  return 3 if game[0] == "A" && game[1] == "X"
  return 3 if game[0] == "B" && game[1] == "Y"
  return 3 if game[0] == "C" && game[1] == "Z"
  0
end

def points_from_game(game)
  points = 0
  case game[1]
  when "X"
    case game[0]
    when "A"
      points += 3
    when "B"
      points += 1
    when "C"
      points += 2
    end
  when "Y"
    points += 3
    case game[0]
    when "A"
      points += 1
    when "B"
      points += 2
    when "C"
      points += 3
    end
  when "Z"
    points += 6
    case game[0]
    when "A"
      points += 2
    when "B"
      points += 3
    when "C"
      points += 1
    end
  end
  points
end

p part2(data)