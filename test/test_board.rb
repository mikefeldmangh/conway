gem "minitest"
require 'minitest/autorun'
require_relative 'helper'

class TestBoard < MiniTest::Unit::TestCase
  def setup
   # @board = Board.new
  end
  
  def test_default_dimensions
    @board = Board.new
    assert_equal 5, @board.width
    assert_equal 5, @board.height
  end
  
  def test_set_demensions
    @board = Board.new 6, 6
    assert_equal 6, @board.width
    assert_equal 6, @board.height
  end
  
  def test_cells_initially_nil
    @board = Board.new
    assert_nil @board.cells
  end
  
  def test_cells_wrong_dimension
    @board = Board.new 5, 5
    cells = [[true, false, false],
             [true, false, false],
             [false, true, true]]
    assert_raises RuntimeError do
      @board.set_cells cells
    end
  end
  
  def setup_good_board
    @board = Board.new 3, 3
    cells = [[true, false, false],
             [true, false, false],
             [false, true, true]]
    @board.set_cells cells
  end
  
  def test_cells_correct_dimension
    setup_good_board
    assert_equal 3, @board.cells.length
    assert_equal 3, @board.cells[0].length
  end
  
  def test_calulate_num_live_neighbors
    setup_good_board
    num_live_neighbors = @board.calculate_num_live_neighbors 0, 0
    assert_equal 1, num_live_neighbors
    num_live_neighbors = @board.calculate_num_live_neighbors 0, 1
    assert_equal 2, num_live_neighbors
    num_live_neighbors = @board.calculate_num_live_neighbors 0, 2
    assert_equal 0, num_live_neighbors
    num_live_neighbors = @board.calculate_num_live_neighbors 1, 0
    assert_equal 2, num_live_neighbors
    num_live_neighbors = @board.calculate_num_live_neighbors 1, 1
    assert_equal 4, num_live_neighbors
    num_live_neighbors = @board.calculate_num_live_neighbors 1, 2
    assert_equal 2, num_live_neighbors
    num_live_neighbors = @board.calculate_num_live_neighbors 2, 0
    assert_equal 2, num_live_neighbors
    num_live_neighbors = @board.calculate_num_live_neighbors 2, 1
    assert_equal 2, num_live_neighbors
    num_live_neighbors = @board.calculate_num_live_neighbors 2, 2
    assert_equal 1, num_live_neighbors
  end
  
  def test_calculate_next_state_of_cell
    setup_good_board
    next_state = @board.calculate_next_state_of_cell 0, 0
    assert_equal false, next_state 
    next_state = @board.calculate_next_state_of_cell 0, 1
    assert_equal false, next_state 
    next_state = @board.calculate_next_state_of_cell 0, 2
    assert_equal false, next_state 
    next_state = @board.calculate_next_state_of_cell 1, 0
    assert_equal true, next_state 
    next_state = @board.calculate_next_state_of_cell 1, 1
    assert_equal false, next_state 
    next_state = @board.calculate_next_state_of_cell 1, 2
    assert_equal false, next_state 
    next_state = @board.calculate_next_state_of_cell 2, 0
    assert_equal false, next_state 
    next_state = @board.calculate_next_state_of_cell 2, 1
    assert_equal true, next_state 
    next_state = @board.calculate_next_state_of_cell 2, 2
    assert_equal false, next_state 
  end
  
  def test_get_next_iteration
    setup_good_board
    next_board = @board.get_next_iteration
  end
  
  def test_set_live_cells
    w = 3
    h = 3
    @board = Board.new w, h
        
    live_cells = [[0, 0], [1, 0], [2, 1], [2, 2]]
    @board.set_live_cells live_cells
    
    assert_equal true, @board.cells[0][0]
    assert_equal false, @board.cells[0][1]
    assert_equal false, @board.cells[0][2]
    assert_equal true, @board.cells[1][0]
    assert_equal false, @board.cells[1][1]
    assert_equal false, @board.cells[1][2]
    assert_equal false, @board.cells[2][0]
    assert_equal true, @board.cells[2][1]
    assert_equal true, @board.cells[2][2]
    
  end
end