helpers do

  def cell_value(value)
    value.to_i == 0 ? '' : value
  end

  def cell_readonly(puzzle_value)
    return 'readonly' if puzzle_value != 0
    return ''
  end

  def colour_class(solution_to_check, puzzle_value, current_solution_value, solution_value)
    must_be_guessed = puzzle_value == 0
    #I needed to change this 0 to "0" otherwise all the cells show up as value provided
    tried_to_guess = current_solution_value.to_i != 0
    guessed_incorrectly = current_solution_value != solution_value

    if solution_to_check && 
        must_be_guessed && 
        tried_to_guess && 
        guessed_incorrectly
      'incorrect'
    elsif !must_be_guessed
      'value-provided'
    end
  end
end