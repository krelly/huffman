# Huffman tree node
class Node < Struct.new(:value, :weight, :left, :right)
  include Comparable

  def +(other)
    self.class.new(value + other.value, weight + other.weight, self, other)
  end

  def leaf?
    left.nil? && right.nil?
  end

  def <=>(other)
    weight <=> other.weight
  end
end