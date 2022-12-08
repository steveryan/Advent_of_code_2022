data = File.read("data/day8.txt").lines.map(&:strip).map(&:chars).map { |x| x.map(&:to_i) }

ROW_MIN = 0
ROW_MAX = data.length - 1
COL_MIN = 0
COL_MAX = data[0].length - 1

def check_visible?(data, row, col)
  return true if check_outer_visibility(data, row, col)
  return true if check_top_visibility(data, row, col)
  return true if check_bottom_visibility(data, row, col)
  return true if check_left_visibility(data, row, col)
  return true if check_right_visibility(data, row, col)
  false
end

def check_outer_visibility(data, row, col)
  if row == ROW_MIN || row == ROW_MAX || col == COL_MIN || col == COL_MAX
    return true
  end
  false
end

def check_top_visibility(data, row, col)
  for i in ROW_MIN.upto(row - 1)
    return false if data[i][col] >= data[row][col]
  end
  true
end

def check_bottom_visibility(data, row, col)
  for i in (row + 1).upto(ROW_MAX)
    return false if data[i][col] >= data[row][col]
  end
  true
end

def check_left_visibility(data, row, col)
  for i in COL_MIN.upto(col - 1)
    return false if data[row][i] >= data[row][col]
  end
  true
end

def check_right_visibility(data, row, col)
  for i in (col + 1).upto(COL_MAX)
    return false if data[row][i] >= data[row][col]
  end
  true
end

def part_1(data)
  visible_count = 0
  for row in ROW_MIN.upto(ROW_MAX)
    for col in COL_MIN.upto(COL_MAX)
      visible_count += 1 if check_visible?(data, row, col)
    end
  end
  visible_count
end

def part_2(data)
  max_score = 0
  for row in ROW_MIN.upto(ROW_MAX)
    for col in COL_MIN.upto(COL_MAX)
      score = get_scenic_score(data, row, col)
      max_score = score if score > max_score
    end
  end
  max_score
end

def get_scenic_score(data, row, col)
  score = 0
  up_score = check_up_score(data, row, col)
  down_score = check_down_score(data, row, col)
  left_score = check_left_score(data, row, col)
  right_score = check_right_score(data, row, col)
  score = up_score * down_score * left_score * right_score
  score
end

def check_up_score(data, row, col)
  score = 0
  return score if row == ROW_MIN
  for i in (row-1).downto(ROW_MIN)
    score += 1
    return score if data[i][col] >= data[row][col]
  end
  score
end

def check_down_score(data, row, col)
  score = 0
  return score if row == ROW_MAX
  for i in (row+1).upto(ROW_MAX)
    score += 1
    return score if data[i][col] >= data[row][col]
  end
  score
end

def check_left_score(data, row, col)
  score = 0
  return score if col == COL_MIN
  for i in (col-1).downto(COL_MIN)
    score += 1
    return score if data[row][i] >= data[row][col]
  end
  score
end

def check_right_score(data, row, col)
  score = 0
  return score if col == COL_MAX 
  for i in (col+1).upto(COL_MAX)
    score += 1
    return score if data[row][i] >= data[row][col]
  end
  score
end

p "Part 1: #{part_1(data)}"
p "Part 2: #{part_2(data)}"