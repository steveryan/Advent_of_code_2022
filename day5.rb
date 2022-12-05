data = File.read("data/day5.txt").lines.map(&:strip)
split_index = data.find_index("")
starting_stacks = data[0..split_index-2]
instructions = data[split_index+1..]

stacks = {}
stacks[1] = ["Z", "N"]
stacks[2] = ["M", "C", "D"]
stacks[3] = ["P"]

prod_stacks = {}
prod_stacks[1] = ["S", "T", "H", "F", "W", "R"]
prod_stacks[2] = ["S", "G", "D", "Q", "W"]
prod_stacks[3] = ["B", "T", "W"]
prod_stacks[4] = ["D", "R", "W", "T", "N", "Q", "Z", "J"]
prod_stacks[5] = ["F", "B", "H", "G", "L", "V", "T", "Z"]
prod_stacks[6] = ["L", "P", "T", "C", "V", "B", "S", "G"]
prod_stacks[7] = ["Z", "B", "R", "T", "W", "G", "P"]
prod_stacks[8] = ["N", "G", "M", "T", "C", "J", "R"]
prod_stacks[9] = ["L", "G", "B", "W"]

stacks = {}
stacks = prod_stacks
clean_stacks_for_part_2 = Marshal.load(Marshal.dump(stacks))

instructions = instructions.map do |line|
  line.scan(/\d+/).map(&:to_i)
end

def move_part_1(instruction, stacks)
  num_crates = instruction[0]
  from_stack = instruction[1]
  to_stack = instruction[2]

  num_crates.times do
    stacks[to_stack].push(stacks[from_stack].pop)
  end
  stacks
end

def move_part_2(instruction, stacks)
  num_crates = instruction[0]
  from_stack = instruction[1]
  to_stack = instruction[2]

  stacks[to_stack].push(stacks[from_stack].pop(num_crates)).flatten!
  
  stacks
end



def get_top_crates(stacks)
  top_crates = []
  stacks.values.each do |stack|
    top_crates << stack.last
  end
  top_crates.join("")
end

def part_1(stacks, instructions)
  instructions.each do |instruction|
    stacks = move_part_1(instruction, stacks)
  end
  get_top_crates(stacks)
end

def part_2(stacks, instructions)
  instructions.each do |instruction|
    stacks = move_part_2(instruction, stacks)
  end
  get_top_crates(stacks)
end

p "Part 1: #{part_1(stacks, instructions)}"
p "Part 2: #{part_2(clean_stacks_for_part_2, instructions)}"