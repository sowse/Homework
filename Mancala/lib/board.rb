class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @name1_cup = 6
    @name2_cup = 13
    @cups = Array.new(14) {Array.new}
    place_stones
  end

  def place_stones
    @cups.each_with_index {|cup, i| 4.times{cup << :stone} unless i == 6 || i == 13}
  end

  def valid_move?(start_pos)
    start_pos -= 1 if (1..6).include?(start_pos)
    raise ArgumentError.new "Invalid starting cup" unless (0..5).include?(start_pos) || (7..12).include?(start_pos)
    raise ArgumentError.new "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    @current_pos = start_pos
    @starting_cup = @cups[start_pos]
    @self_cup = @name1 == current_player_name ? @name1_cup : @name2_cup
    @opponent_cup = @name1 == current_player_name ? @name2_cup : @name1_cup 
    @hand = []
    @hand << @starting_cup.shift until @starting_cup.empty?

    until @hand.empty?
      @current_pos = (@current_pos + 1) % 14
      @cups[@current_pos] << @hand.shift unless @current_pos == @opponent_cup
    end
    self.render

    return self.next_turn(@current_pos)
  end

  def next_turn(ending_cup_idx)
    return :prompt if ending_cup_idx == @self_cup
    return :switch if @cups[ending_cup_idx].count == 1
    return ending_cup_idx  
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    (0..5).all? {|idx| @cups[idx].empty?} || (7..12).all? {|idx| @cups[idx].empty?}
  end

  def winner
    return :draw if @cups[@name1_cup].count == @cups[@name2_cup].count
    return @cups[@name1_cup].count > @cups[@name2_cup].count ? @name1 : @name2
  end
end
