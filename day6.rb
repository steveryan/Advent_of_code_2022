data = File.read("data/day6.txt")

def part_1(data)
  i = 0
  while i < (data.length - 3)
    test_array = [data[i],data[i+1], data[i+2], data[i+3]]
    if test_array == test_array.uniq
      return i+4
    end 
    i += 1
  end
end


def part_2(data)
  i = 0
  while i < (data.length - 13)
    test_array = data[i..i+13].chars
    if test_array == test_array.uniq
      return i+14
    end
    i += 1
  end
end

p "Part 1: #{part_1(data)}"
p "Part 2: #{part_2(data)}"