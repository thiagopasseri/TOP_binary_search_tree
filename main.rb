require_relative 'lib/binary_tree'
require_relative 'lib/node'


# array = [0, 0.5,1,2,3,4,5,6,7]
array = [1,3,4,5,6,7,9,10,11,15,16,17]

# array = [0,1,2,3,4,5,6,7,8,9,10,11,12]


tree = Tree.new(array)
tree.pretty_print
# p  tree.find_parent(3).data
# p tree.find_parent(2)

# tree.level_order {|node| puts "node: #{node.data}"}
# p tree.depth(22)
# p tree.post_order 

p tree.height(tree.root.left)
p tree.balanced?
tree.insert(18)
tree.insert(19)
tree.insert(20)
tree.insert(21)

tree.pretty_print
p tree.balanced?


tree.delete(19)
tree.pretty_print

p tree.balanced?
tree.delete(20)
tree.pretty_print


p tree.balanced?
tree.delete(7)
tree.pretty_print

p tree.balanced?
tree.delete(5)
tree.pretty_print

# tree.post_order  {|node| puts "node: #{node.data}"}
# tree.pre_order  {|node| puts "node: #{node.data}"}
# tree.post_order  {|node| puts "node: #{node.data}"}

# p tree.sucessor(tree.root).data
# p tree.pretty_print


# p tree.root.left.left.right