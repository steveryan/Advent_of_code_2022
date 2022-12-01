data = File.read("data/day1.txt").lines.map(&:strip)

def list_calories_per_elf(data)
  elf_calorie_list = []
  temp_total = 0
  data.each do |line|
    if line == ""
      elf_calorie_list << temp_total
      temp_total = 0
    else
      temp_total += line.to_i
    end
  end
  elf_calorie_list << temp_total
end

def part1(data)
  elf_calorie_list = list_calories_per_elf(data)
  elf_calorie_list.max
end

def part2(data)
  elf_calorie_list = list_calories_per_elf(data)
  elf_calorie_list.max(3).sum
end

p "Part 1: #{part1(data)}"
p "Part 2: #{part2(data)}"