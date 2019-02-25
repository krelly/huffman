require 'rspec'
require 'huffman_encoder'
require 'huffman_tree'

describe 'HuffmanEncoder' do

  let(:text)        { 'Sample text to test'}
  let(:text2)       { 'This text is different'}
  let(:tree)        { HuffmanTree.build_tree(text) }
  let(:encoder)     { HuffmanEncoder.new(tree) }
  it 'should decode text ' do
    compressed = encoder.encode(text)
    decoded = encoder.decode(compressed)

    expect(text).to eq(decoded)
  end

  it 'should decode text using reconstructed tree' do
    compressed = encoder.encode(text)
    encoded_tree = tree.encode_tree
    reconstructed_tree = HuffmanTree.reconstruct_tree(encoded_tree.to_s)
    encoder2 = HuffmanEncoder.new(reconstructed_tree)
    decoded = encoder2.decode(compressed)

    expect(text).to eq(decoded)
  end

  it 'should encode text in same way using reconstructed tree' do
    compressed = encoder.encode(text)
    reconstructed_tree = HuffmanTree.reconstruct_tree(tree.encode_tree.to_s)
    encoder2 = HuffmanEncoder.new(reconstructed_tree)

    expect(compressed).to eq(encoder2.encode(text))
  end

  it 'should raise exception when text can\'t be encoded with given tree' do
    expect { encoder.encode(text2) }.to raise_error(KeyError)
  end

end