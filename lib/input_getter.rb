
class InputGetter

  def initialize(input = $stdin)
    @input = input
  end


  def get_alive_symbol
    puts "Please set your alive symbol:"
    return @input.gets.chomp()
  end

  def get_dead_symbol
    puts "Please set your dead symbol:"
    return @input.gets.chomp()
  end

  def get_number_of_rows
    puts "Please enter the number of rows:"
    return @input.gets.chomp().to_i
  end

  def get_number_of_columns
    puts "Please enter the number of columns:"
    return @input.gets.chomp().to_i
  end

  def get_number_of_evolutions
    puts "Please enter the number of evolutions:"
    return @input.gets.chomp().to_i
  end

  def get_defaults_prompt_response
    @input.gets.chomp() == "y" ? true : false
  end


end