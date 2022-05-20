class Stack
    def initialize
        @stack = []
    end

    def push(el)
        @stack << el
    end
    
    def pop
        @stack = @stack[0...-1]
    end

    def peek
        @stack[-1]
    end
end

class Queue
    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue << el
    end

    def dequeue
        @queue = @queue[1..-1]
    end

    def peek
        @queue[0]
    end
end

class Map
    def initialize
        @map = []
    end

    def set(key, value)
        exists = false
        @map.each do |ele|
            if ele[0] == key
                ele[1] = value
                exists = true
                break
            end
        end
        @map << [key, value] if exists == false
    end

    def get(key)
        @map.each do |ele|
            return ele[1] if ele[0] == key
        end
    end

    def delete(key)
        @map.each_with_index do |ele, i|
            @map = @map[0...i] + @map[i+1..-1] if ele[0] == key
        end
    end

    def show
        @map
    end
end
