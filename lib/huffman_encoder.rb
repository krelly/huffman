# Encodes/decodes data using pre-generated huffman tree
class HuffmanEncoder
  def initialize(tree)
    @tree = tree
  end

  def encode(text)
    text.chars.map { |c| @tree.char_code[c] }.join
  end

  def decode(compressed)
    path = StringIO.new(compressed)
    decompressed = ''
    decompressed << @tree.node_at(path).value until path.eof?
    decompressed
  end
end