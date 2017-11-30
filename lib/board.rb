class Board

  attr_accessor :cells

  def initialize
     reset!
  end

  def reset!
   @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(input)
    @cells[input.to_i-1]
  end

  def full?
    @cells.all? {|x| x != " "}
  end

  def turn_count
    @cells.collect {|x| x == " "}.size / 3
  end

  def taken?(position)
    cells[position.to_i - 1] == "X" || cells[position.to_i - 1] == "O"
  end

  def valid_move?(position)
     !(taken?(position))  && (0..9).include?(position.to_i - 1)
  end

  token = 0

  def update(index, player)
    position = index.to_i - 1
    !taken?(index) ? @cells[position] = player.token : nil
  end

end
