require_relative 'node'
require_relative 'sorted_list'

class HuffmanTree
  MAX_VAL_BITSIZE = 32

  attr_reader :char_code
  attr_reader :head

  def self.reconstruct_tree(str)
    new decode_tree(StringIO.new(str))
  end

  def self.build_tree(text)
    nodes = order_by_frequency(text)

    loop do
      left = nodes.shift

      return new(left) if nodes.empty?

      right = nodes.shift
      nodes << left + right
    end
  end

  def initialize(head)
    @head = head
    @char_code = {}

    build_char_codes(head, '')
  end

  # depth-first traversal is used
  def build_char_codes(node, key)
    build_char_codes(node.left, key + '0') if node.left
    build_char_codes(node.right, key + '1') if node.right
    @char_code[node.value] = key if node.leaf?
  end

  def encode_tree(io = StringIO.new, node = @head)
    if node.leaf?
      # puts node.value if node.value.unpack('B*').pack('B*') != node.value
      io.write '1'
      bits = node.value.unpack('B*').first
      if bits.size > MAX_VAL_BITSIZE
        raise EncodingError, "character \\u#{node.value.codepoints[0].to_s(16)} is #{bits.size} bits," \
                             "but max allowed size is #{MAX_VAL_BITSIZE}"
      end
      io.write bits.rjust(MAX_VAL_BITSIZE, '0')
    else
      io.write '0'
      encode_tree(io, node.left)
      encode_tree(io, node.right)
    end
    io.string if node == @head
  end

  def node_at(path, node = @head)
    until node.leaf?
      node = case path.read(1)
             when '0' then
               node.left
             when '1' then
               node.right
             end
    end
    node
  end

  class << self
    private

    def decode_tree(io)
      case io.getc
      when '0'
        left = decode_tree(io)
        right = decode_tree(io)
        Node.new("#{left.value}#{right.value}", 0, left, right)
      when '1'
        b = io.read(MAX_VAL_BITSIZE)
        a = b.to_i(2)
        Node.new(a.chr, 1) # .pack("B*")
      end
    end

    def order_by_frequency(text)
      nodes = text
              .chars
              .each_with_object(Hash.new(0)) { |char, h| h[char] += 1 }
              .map { |char, weight| Node.new(char, weight) }
      SortedList.new(nodes)
    end
  end

end