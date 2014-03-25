class Scan
  def initialize(max)
    @min = max
    @max = max
  end

  def scaning_start(map)
    @start = nil
    @map = map
    @max.times do |i|
      
      if @map[i].size<@min && @map[i].size != 0 then
        @min = @map[i].size
        @start = i
      end

    end

    return @start

  end

  def scaning_root(neighbor)
    next_island_num = nil
    count_max = 0
    far_island = nil
    
    neighbor.each_with_index do |next_island, i|
      count = 1
      far_island = @map[next_island][i]

      @max.times do |j|

        if far_island == nil
          break
        end

        count += 1
        far_island = @map[far_island][j]

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

  def stamp_rarry
  	root = []
  	loop{
      root << @start
      island_delete(@start)
      neighbor = @map[@start]
      next_island = scaning_root(neighbor)

      if next_island == nil then
        puts "nothing neighbor island"
        root << neighbor[0]
        break
      end

      neighbor = next_island
      @start = neighbor
    }
    return root
  end

  def island_delete(start)

    @max.times do |i|
      @map[i].delete(start)
    end

  end

end

class FileAccess
  def initialize(filename1, filename2)
    @map_data = filename1
    @stampsheet = filename2
    @map = []
  end

  def map_open
    return open(@map_data,"r")
  end

  def map_load
  	f = map_open
    max = f.gets.chomp.to_i
    map_all = f.readlines

    max.times do |i|
      @map[i] = map_all[i].split(/\s/)
      @map[i].map!{|array| array.to_i(10)}
    end

    return max, @map
  end

  def map_close
    return map_open.close
  end

  def stampsheet_open
    return open(@stampsheet,"w")
  end

  def stampsheet_write(root)
    return stampsheet_open.puts(root)
  end

  def stampsheet_close
    return stampsheet_open.close
  end

end

map = []
file_access = FileAccess.new("map.txt", "stampsheet.txt")
file_access.map_open
max,map = file_access.map_load
file_access.map_close
scan = Scan.new(max)
scan.scaning_start(map)
root = scan.stamp_rarry
file_access.stampsheet_open
file_access.stampsheet_write(root)
file_access.stampsheet_close
