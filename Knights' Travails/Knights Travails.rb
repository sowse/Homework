require './PolyTreeNode.rb'

class KnightPathFinder
    
    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        self.build_move_tree
    end

    def root_node
        @root_node
    end
    def self.valid_moves(pos)
        x, y = pos
        poss_moves = [[x+1, y+2], [x-1, y+2], [x+1, y-2], [x-1, y-2], [x+2, y-1], [x+2, y+1], [x-2, y+1], [x-2, y-1]]
        poss_moves.reject do |move|
            move.any?{|cood| cood > 7 || cood < 0}
        end
    end

    def new_move_positions(pos)
        valid_moves = KnightPathFinder.valid_moves(pos)
        @new_moves = valid_moves.reject{|move| @considered_positions.include?(move)}
        @considered_positions += @new_moves
        @new_moves
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            current_node = queue.shift
            current_position = current_node.value
            new_positions = self.new_move_positions(current_position)
            new_nodes = new_positions.map{|pos| PolyTreeNode.new(pos)}
            new_nodes.each{|node| current_node.add_child(node)}
            queue += new_nodes
        end
    end

    def trace_path_back(node)
        current_node = node
        path = []
        until current_node.parent == nil
            path = [current_node.value] + path
            current_node = current_node.parent
        end
        [@root_node.value] + path
    end                    
    def find_path(end_pos)
        end_node = @root_node.dfs(end_pos)
        trace_path_back(end_node)
    end
end