class Searcher
  def initialize(max,map)
    @max = max
    @map = map
  end

  def stamp_rally
    route = []
    search_first_island
    loop do
      route << @start
      delete_with_island(@start)
      neighbor = @map[@start]
      next_island = search_route(neighbor)
      if next_island.nil?
        puts "nothing neighbor island"
        route << neighbor[0]
        break
      end
      neighbor = next_island
      @start = neighbor
    end
    return route
  end

private
  def search_first_island
    @start = nil
    min = @max
    @max.times do |i|
      if @map[i].size<min && @map[i].size != 0 then
        min = @map[i].size
        @start = i
      end
    end
  end

  def search_route(neighbor)
    @next_island_num = nil
    @count_max = 0
    @far_island = nil
    @neighbor = neighbor
    check_next_island
    if @next_island_num.nil?
      return nil
    else
      return @neighbor[@next_island_num]
    end
  end

  def check_next_island
    @neighbor.each_with_index do |next_island, i|
      count = 1
      @far_island = @map[next_island][i]
      @max.times do |j|
        if @far_island.nil?
          break
        end
        count += 1
        @far_island = @map[@far_island][j]
        if count > @count_max && @far_island != nil then
          @count_max = count
          @next_island_num = i
        end
      end
    end
  end
  
  def delete_with_island(island)
    @max.times do |i|
      @map[i].delete(island)
    end
  end
end

class FileManager
  def read(file_name)
    @input_file = open(file_name,"r")
    map_data = [number_of_islands,islands]
    @input_file.close
    return map_data
  end

  def write_with_route(route)
    f = open("stampsheet.txt","w")
    f.puts(route)
    f.close
  end

private
  def number_of_islands
    return @input_file.gets.chomp.to_i
  end

  def islands
    map = []
    @input_file.readlines.each do |map_data|
      map << map_data.split(" ").map{|array| array.to_i}
    end
    return map
  end
end

file_manager = FileManager.new
max,map = file_manager.read("map.txt")
searcher = Searcher.new(max, map)
route = searcher.stamp_rally
file_manager.write_with_route(route)
