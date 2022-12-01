require_relative 'validator'

def solve_sudoku(sudoku)
  solved_amount = 0
  mutable_indexes = sudoku.map { |row|
    row.map { |cell|
      result = true
      if cell != 0
        solved_amount += 1
        result = false
      end
      result
    }
  }

  recursive_solve(sudoku, mutable_indexes, solved_amount, {
    row: 0,
    col: 0
  })
end

def recursive_solve(sudoku, mutable_indexes, solved_amount, coord)
  @exit_status = false
  def solve(sudoku, mutable_indexes, solved_amount, coord)
    if solved_amount === 81
      @exit_status = true
      return sudoku
    end

    unless mutable_indexes[coord[:row]][coord[:col]]
      return solve(sudoku, mutable_indexes, solved_amount, get_sudoku_next_cell_coord(coord))
    end

    (1..9).each { |i|
      if !@exit_status
        if validate_cell_on_collisions(sudoku, coord, i)
          sudoku[coord[:row]][coord[:col]] = i
          sudoku = solve(sudoku, mutable_indexes, solved_amount + 1, get_sudoku_next_cell_coord(coord))
        end
      else
        break
      end
    }

    unless @exit_status
      sudoku[coord[:row]][coord[:col]] = 0
    end

    sudoku
  end

  solve(sudoku, mutable_indexes, solved_amount, coord)
end

def get_sudoku_next_cell_coord(coord)
  {
    row: coord[:row] + (coord[:col] / 8).floor,
    col: (coord[:col] + 1) % 9
  }
end
