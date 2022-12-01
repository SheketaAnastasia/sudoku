def validate_sudoku(sudoku)
  (0..8).each { |i|
    (0..8).each { |j|
      if sudoku[i][j] != 0 && !validate_cell_on_collisions(sudoku, { row: i, col: j }, sudoku[i][j])
        return false
      end
    }
  }

  true
end

def validate_cell_on_collisions(sudoku, coord, checked_number)
  validate_row_on_collisions(sudoku, coord, checked_number) && validate_column_on_collisions(sudoku, coord, checked_number) && validate_block_on_collisions(sudoku, coord, checked_number)
end

def validate_row_on_collisions(sudoku, coord, checked_number)
  (0..8).each { |i|
    if coord[:col] != i
      if sudoku[coord[:row]][i] === checked_number
        return false
      end
    end
  }

  true
end

def validate_column_on_collisions(sudoku, coord, checked_number)
  (0..8).each { |i|
    if coord[:row] != i && sudoku[i][coord[:col]] === checked_number
      return false
    end
  }

  true
end

def validate_block_on_collisions(sudoku, coord, checked_number)
  block_start_breakpoints = [0, 3, 6]
  block_end_breakpoints = [2, 5, 8]
  row_block_index = (coord[:row] / 3).floor
  column_block_index = (coord[:col] / 3).floor

  (block_start_breakpoints[row_block_index]..block_end_breakpoints[row_block_index]).each { |i|
    (block_start_breakpoints[column_block_index]..block_end_breakpoints[column_block_index]).each { |j|
      if i != coord[:row] && j != coord[:col] && sudoku[i][j] === checked_number
        return false
      end
    }
  }

  true
end
