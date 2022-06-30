require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    evaluator == :x ? opponent = :o : opponent = :x
    return @board.winner == opponent ? true : false if @board.over?
        
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @next_mover_mark == :x ? next_mark = :o : next_mark = :x
    (0..2).each do |x|
      (0..2).each do |y|
        pos = [x,y]
        if @board.empty?(pos)
          child_board = @board.dup
          child_board[pos] = next_mark
          children << TicTacToeNode.new(child_board, next_mark, pos)
        end
      end
    end
    children
  end


end
