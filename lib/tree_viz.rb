require 'ruby-graphviz'
require_relative 'huffman_tree'

# Draws a visual representation of Huffman Tree
class TreeViz < HuffmanTree
  attr_reader :graph

  def initialize(source_node)
    @graph = GraphViz.new(:G)
    traverse(source_node, '')
  end

  def traverse(node, key)
    g_node = @graph.add_nodes(node.value.inspect) #{node.weight}

    if node.left
      lefty = traverse(node.left, key + '0')
      edge = @graph.add_edges(g_node, lefty)
      edge[:label] = ' 0'
    end
    if node.right
      righty = traverse(node.right, key + '1')
      edge = @graph.add_edges(g_node, righty)
      edge[:label] = ' 1'
    end
    g_node
  end
end
