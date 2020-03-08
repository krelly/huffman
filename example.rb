require_relative 'lib/huffman_tree'
require_relative 'lib/huffman_encoder'
require_relative 'lib/tree_viz'


# TODO:
# more tests
# encoding arbitrary length utf characters: like this one "’"


text = "
Bad bad bad boy
All of your girlfriends are bad bad girls
We don't care about the risk, we're, we're unlucky
And you're unlucky, unlucky
And you're a Bad bad bad boy
All of your girlfriends are bad bad girls
We don't care about the risk, we're, we're unlucky
And you're unlucky, unlucky
"

tree = HuffmanTree.build_tree(text)
encoder = HuffmanEncoder.new(tree)
compressed = encoder.encode(text)
encoded_tree = tree.encode_tree
reconstructed_tree = HuffmanTree.reconstruct_tree(encoded_tree)

enc2 = HuffmanEncoder.new(reconstructed_tree)
decoded = enc2.decode(compressed)


# Some stats
original_size = text.bytesize
compressed_string_size = [compressed].pack('B*').bytesize

dictionary_size = [encoded_tree].pack('B*').bytesize
total_encoded_size = (compressed_string_size + dictionary_size).abs
saved_bytes = original_size - total_encoded_size
saved_in_percents = 100 - (total_encoded_size * 100.0 / original_size)

puts 'Statistics:'
puts "Source string size: #{original_size} bytes"
print "Compressed size: compressed string: #{compressed_string_size} bytes + "
puts "encoded huffman tree: #{dictionary_size} bytes = #{total_encoded_size} bytes"
puts "Saved #{saved_bytes} bytes or #{saved_in_percents.round(1)}%"

g = TreeViz.new(tree.head)
g.graph.output(png: 'tree.png')

g2 = TreeViz.new(reconstructed_tree.head)
g2.graph.output(png: 'reconstructed_tree.png')