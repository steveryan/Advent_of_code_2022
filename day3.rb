data = File.read("data/day3.txt").lines.map(&:strip).map(&:chars)

lowercase = Hash[('a'..'z').to_a.zip((1..26).to_a)]
uppercase = Hash[('A'..'Z').to_a.zip((27..52).to_a)]
PRIORITY_HASH = lowercase.merge(uppercase)

def part1(data)
  overlap_array = []
  data.each do |backpack|
    middle = (backpack.length / 2) - 1
    left = backpack[0..middle]
    right = backpack[middle + 1..]
    overlap = left & right
    overlap_array << overlap.first
  end

  priority_total = get_priority_total(overlap_array)
end

def part2(data)
  overlap_array = []
  groups = data.each_slice(3).to_a

  groups.each do |group|
    common_element = group[0] & group[1] & group[2]
    overlap_array << common_element.first
  end
  
  priority_total = get_priority_total(overlap_array)
end

def get_priority_total(overlap_array)
  priority_total = 0
  overlap_array.each do |overlap|
    priority_total += PRIORITY_HASH[overlap]
  end
  priority_total
end

p "Part 1: #{part1(data)}"
p "Part 2: #{part2(data)}"