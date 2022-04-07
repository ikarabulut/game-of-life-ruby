
class InputGetter

  def get_alive_symbol
    puts "Please set your alive symbol:"
    gets.chomp()
  end

  def get_dead_symbol
    puts "Please set your dead symbol:"
    gets.chomp()
  end

  def get_number_of_rows
    puts "Please enter the number of rows:"
    gets.chomp().to_i
  end

  def get_number_of_columns
    puts "Please enter the number of columns:"
    gets.chomp().to_i
  end

  def get_number_of_evolutions
    puts "Please enter the number of evolutions:"
    gets.chomp().to_i
  end


end