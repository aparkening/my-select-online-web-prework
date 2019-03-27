# Returns new array for which block's condition is true
def my_select(collection)
  new_collection = [ ]
  i = 0
  while i < collection.length
    new_collection[i] = yield(collection[i])
    # new_collection << yield(collection[i]) # Could also use shovel
    i += 1
  end
  new_collection                   # Return modified array



end



  it "can handle an empty collection" do
    empty_array = []
    saved_block = Proc.new {
      my_select(empty_array) do |x|
        raise "This block should not run!"
      end
    }
    expect(saved_block).to_not raise_error
  end

  it "yields the correct element" do
    my_select(nums) do |number|
      expect(number).to_not eq(nil)
    end
  end

  it "selects the items in the collection to which the block returns true" do
    expect(my_select(nums) do |num|
      num.even?
    end).to eq([2, 4])
  end

  it 'does not modify the original collection' do
    my_select(nums) do |num|
      num.even?
    end
    expect(nums).to eq([1, 2, 3, 4, 5])
  end