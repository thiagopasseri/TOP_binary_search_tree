require_relative 'lib/binary_tree'
require_relative 'lib/node'


# array = [1,3,4,5,6,7,9,10,11,15,16,17]


array = (Array.new(15) { rand(1..100) })
tree = Tree.new(array)
puts "Início"
tree.pretty_print

puts "is balanced" if tree.balanced?
puts "not balanced" unless tree.balanced?


# print "inorder:  "
# p tree.in_order
# print "preorder:  "
# p tree.pre_order
# print "postorder:  "
# p tree.post_order

array2 = (Array.new(10) { rand(5..100) })
array2.each do |value|
  tree.insert(value)
end

tree.pretty_print
puts "is balanced" if tree.balanced?
puts "not balanced" unless tree.balanced?
tree.rebalance

tree.pretty_print
puts "is balanced" if tree.balanced?
puts "not balanced" unless tree.balanced?






# p  tree.find_parent(3).data
# p tree.find_parent(2)

# tree.level_order {|node| puts "node: #{node.data}"}
# p tree.depth(22)
# p tree.post_order 

# p tree.height(tree.root.left)
# p tree.balanced?
# p tree.level_order_iterative

# tree.pretty_print

# tree.insert(20)
# tree.insert(21)
# tree.insert(22)
# tree.insert(23)
# tree.insert(24)

# tree.pretty_print

# p "rebalanced:"
# tree.rebalance

# tree.pretty_print
# p tree.balanced?


# tree.delete(19)
# tree.pretty_print

# p tree.balanced?
# tree.delete(20)
# tree.pretty_print


# p tree.balanced?
# tree.delete(7)
# tree.pretty_print

# p tree.balanced?
# tree.delete(5)
# tree.pretty_print

# tree.post_order  {|node| puts "node: #{node.data}"}
# tree.pre_order  {|node| puts "node: #{node.data}"}
# tree.post_order  {|node| puts "node: #{node.data}"}

# p tree.sucessor(tree.root).data
# p tree.pretty_print


# p tree.root.left.left.right