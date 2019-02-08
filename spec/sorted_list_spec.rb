require 'rspec'
require_relative '../sorted_list'

describe 'My behaviour' do
  let(:arr) { [5, 2, 9, 3] }


  it 'should should sort elements when initialized with array of values' do
    list = SortedList.new(arr)
    expect(list.items).to eq([2,3,5,9])
  end
  it 'should keep elements sorted when pushed' do

    list = SortedList.new
    arr.each { |el| list << el }
    expect(list.items).to eq([2,3,5,9])
  end
end