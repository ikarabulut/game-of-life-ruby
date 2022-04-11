
class InputGetter

  def get_alive_symbol
    puts "Please set your alive symbol:"
    return gets.chomp()
  end

  def get_dead_symbol
    puts "Please set your dead symbol:"
    return gets.chomp()
  end

  def get_number_of_rows
    puts "Please enter the number of rows:"
    return gets.chomp().to_i
  end

  def get_number_of_columns
    puts "Please enter the number of columns:"
    return gets.chomp().to_i
  end

  def get_number_of_evolutions
    puts "Please enter the number of evolutions:"
    return gets.chomp().to_i
  end

  def get_defaults_prompt_response
    gets.chomp() == "y" ? true : false
  end


end