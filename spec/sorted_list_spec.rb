require 'rspec'
require 'sorted_list'

describe 'My behaviour' do
  let(:arr) { [5, 2, 9, 3] }
  let(:sorted) { [6,7,8,10,12,31]}


  it 'should should sort elements when initialized with array of values' do
    list = SortedList.new(arr)
    expect(list.items).to eq(arr.sort)
  end

  it 'should work when elements added one by one' do
    list = SortedList.new
    arr.each { |el| list << el }
    expect(list.items).to eq(arr.sort)
  end

  it 'should work with sorted array' do
    list = SortedList.new(sorted)
    expect(list.items).to eq(sorted)
  end
end