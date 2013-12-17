class Board
  attr_accessor :width, :height, :cells
  
  def initialize w=5, h=5
    @width = w
    @height = h
  end
  
  def set_live_cells live_coords
    @cells = Array.new(height) do |f| 
      f = Array.new(width) { |e| e = false }
    end
    
    live_coords.each do |coord|
      @cells[coord[0]][coord[1]] = true
    end
  end
  
  def set_cells cells
    if width != cells.length || height != cells[0].length
      raise "Wrong dimensions"
    else
      @cells = cells
    end
  end
  
  def calculate_next_state_of_cell x, y
    num_live_neighbors = calculate_num_live_neighbors x, y
    if num_live_neighbors < 2
      false
    elsif num_live_neighbors > 3
      false
    elsif num_live_neighbors == 3
      true
    else
      cells[x][y]
    end
  end
  
  def calculate_num_live_neighbors x, y
    num_live = 0;
    for i in x-1..x+1
      for j in y-1..y+1
        next if i < 0 || j < 0 || i >= height || j >= width || (i == x && j == y)
        num_live += 1 if cells[i][j]
      end
    end
    num_live
  end
  
  def get_next_iteration
    result_board = Board.new width, height
    result_cells = []
    for i in 0..height-1
      result_cells[i] = []
      for j in 0..width-1
        result_cells[i][j] = calculate_next_state_of_cell i, j
      end
    end
    result_board.set_cells result_cells
    result_board
  end
  
end
