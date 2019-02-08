require 'forwardable'

# List, which elements are always sorted
class SortedList
  extend Forwardable

  attr_reader :items
  def_delegators :@items, :shift, :length, :empty?

  def initialize(*args)
    @items = Array.new(*args).sort
  end

  # Using binary search to find a position for inserting new element
  def <<(node)
    l = 0
    r = @items.length - 1
    while l <= r
      pos = (l + r) / 2
      current = @items[pos]
      if current < node
        l = pos + 1
      elsif current > node
        r = pos - 1
      else
        return @items.insert(pos, node)
      end
    end
    @items.insert(l, node)
  end
end