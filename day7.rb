data = File.read("data/day7.txt").lines.map(&:strip)

class Directory
  def initialize(name)
    @name = name
    @data_files = []
    @directories = []
  end

  def name
    @name
  end

  def size
    @size
  end

  def size=(size)
    @size = size
  end

  def data_files
    @data_files
  end

  def add_data_file(data_file)
    @data_files << data_file
  end

  def directories
    @directories
  end

  def add_directory(directory)
    @directories << directory
  end
end

class Data_file
  def initialize(name, size)
    @name = name
    @size = size
  end
  attr_reader :name, :size
end

pwd = ""
directory_hash = {}
data.each do |line|
  commands = line.split(" ")
  if commands[0] == "$"
    if commands[1] == "cd"
      if commands[2] == "/"
        pwd = "/"
        if directory_hash[pwd] == nil
          new_dir = Directory.new(pwd)
          directory_hash[pwd] = new_dir
        end
      elsif commands[2] == ".."
        pwd = pwd.split("/")[0..-2].join("/")
        if pwd == ""
          pwd = "/"
        end
      else
        if pwd == "/"
          pwd += commands[2]
        else
          pwd += "/" + commands[2]
        end
        if directory_hash[pwd] == nil
          new_dir = Directory.new(pwd)
          directory_hash[pwd] = new_dir
        end
      end
    end
  elsif commands[0] == "dir"
    current_dir = directory_hash[pwd]
    if pwd == "/" && directory_hash[pwd + commands[1]] == nil
      new_dir = Directory.new(pwd + commands[1])
    elsif directory_hash[pwd + "/" + commands[1]] == nil
      new_dir = Directory.new(pwd + "/" + commands[1])
    end

    if new_dir
      directory_hash[new_dir.name] = new_dir
      current_dir.add_directory(new_dir)
    end
  else 
    current_dir = directory_hash[pwd]
    file = Data_file.new(commands[1], commands[0].to_i)
    current_dir.add_data_file(file)
  end
end

def get_size(directory)
  size = 0
  directory.data_files.each do |file|
    size += file.size
  end
  directory.directories.each do |dir|
    size += get_size(dir)
  end
  directory.size = size
  size
end


get_size(directory_hash["/"])

def part_2(directory_hash)
  total_disk_size = 70000000
  space_needed_for_update = 30000000
  total_space_used = directory_hash["/"].size
  space_needed = space_needed_for_update - (total_disk_size - total_space_used)
  directory_hash.values.flatten.select { |dir| dir.size >= space_needed }.min_by(&:size).size
end

p "Part 1: #{directory_hash.values.flatten.select { |dir| dir.size <= 100000 }.sum(&:size)}"
p "Part 2: #{part_2(directory_hash)}"


