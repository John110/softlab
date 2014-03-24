class Scan
  def initialize(max)
    @min = max
    @max = max
  end

  def scaning_start(map)
    island = nil
    @max.times do |i|
      
      if map[i].size<@min && map[i].size != 0 then
        @min = map[i].size
        island = i
      end

    end

    return island

  end

  def scaning_root(neighbor, map)
    next_island_num = nil
    count_max = 0
    far_island = nil
    
    neighbor.each_with_index do |next_island, i|
      count = 1
      far_island = map[next_island][i]

      @max.times do |j|

        if far_island == nil
          break
        end

        count += 1
        far_island = map[far_island][j]

        if count > count_max && far_island != nil then
          count_max = count
          next_island_num = i
        end

      end

    end

    if next_island_num == nil then
      return nil
    else
      return neighbor[next_island_num]
    end

  end

  def island_delete(map,start)
    @max.times do |i|
      map[i].delete(start)
    end
    return map
  end

end

class FileAccess
  def initialize(filename1, filename2)
    @map_data = filename1
    @stampsheet = filename2
    @map = []
  end

  def map_open
    return @f_map = open(@map_data,"r")
  end

  def map_load
    max = @f_map.gets.chomp.to_i
    @map_all = @f_map.readlines

    max.times do |i|
      @map[i] = @map_all[i].split(/\s/)
      @map[i].map!{|array| array.to_i(10)}
    end

    return max, @map
  end

  def map_close
    return @f_map.close
  end

  def stampsheet_open
    return @f_stampsheet = open(@stampsheet,"w")
  end

  def stampsheet_write(island_num)
    return @f_stampsheet.puts(island_num)
  end

  def stampsheet_close
    return @f_stampsheet.close
  end

end

file_access = FileAccess.new("map.txt", "stampsheet.txt")
map = []
file_access.map_open
max,map = file_access.map_load
file_access.map_close
scan = Scan.new(max)
start = scan.scaning_start(map)
file_access.stampsheet_open
loop{
  file_access.stampsheet_write(start)
  map = scan.island_delete(map,start)
  neighbor = map[start]
  next_island = scan.scaning_root(neighbor, map)

  if next_island == nil then
    puts "nothing neighbor island"
    file_access.stampsheet_write(neighbor[0])
    break
  end

  neighbor = next_island
  start = neighbor
}

file_access.stampsheet_close
