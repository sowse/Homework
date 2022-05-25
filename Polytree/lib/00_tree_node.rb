class PolyTreeNode
    attr_reader :children, :value, :parent
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def inspect
        @value.inspect
    end
    def parent=(value)
        @parent.children.reject! {|child| child == self} unless @parent == nil
        @parent = value
        @parent.children << self unless @parent == nil
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "Not a child!" if child_node.parent == nil
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if target_value == self.value
        self.children.each do |child|
            poss = child.dfs(target_value)
            return poss if poss != nil
        end
        return nil
    end

    def bfs(target_value)
        field = [self]
        until field.empty?
            current = field.shift
            return current if current.value == target_value 
            field += current.children
        end
    end
end
