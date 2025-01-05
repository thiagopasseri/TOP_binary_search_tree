class Node 
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right 
  end

  def is_leaf?
    return !left && !right
  end
#   def to_s
#     "data: #{@data}, left:#{@left&.data}, right:#{@right&   .data}"
#   end
end