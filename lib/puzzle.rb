class Puzzle

  def initialize(sudoku = [])
  	#@sudoku = sudoku #Array.new(81, 0)
    @solution = sudoku #Array.new(81, 0)
  end

  attr_reader :sudoku, :solution

  def generate_puzzle(type )
    choice = {:easy =>32, :mid=>46, :hard => 51}
    hide_cells(choice[type])
    format_cells

  end

  def format_cells
    @solution.each_with_index{|c, i|
     @solution[i] = '' if c == 0 
    }

  end
  
  def inspect
    @solution.each_with_index {|row, index|
      print row.to_s+' '
      print "\n" if (index+1)%9==0
    }

  end

  def hide_cells(type)
    skipper = false
    type.times {
     
      25.times{
      try = rand(81)-1
      #puts try.to_s+ " --- "
      if (make_column(try,type) && make_row(try,type) && @solution[try] != 0)
        @solution[try] = 0 
        skipper = true
      end
      break if skipper
      }

    }
    @solution

  end

   def make_column(cell,type)
    element_count = (type/9)+1
    element_column, key, position_shift = 0, 0, (cell%9)
    0.upto(8) {|iter|
      key = (iter * 9) + position_shift
      element_column+=1 if @solution[key] == 0 
    }
     return false if  element_column > element_count
     true
  end

  def make_row(cell,type)
     element_count = (type/9)+1
    element_column, key = 0, (cell/9)*9
    (key).upto(key+8) {|iter|
       element_column+=1 if @solution[key] == 0 
    }
    return false if element_column > element_count
    true
  end

end