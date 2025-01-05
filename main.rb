require_relative 'lib/binary_tree'
require_relative 'lib/node'


# array = [0, 0.5,1,2,3,4,5,6,7]
array = [1,3,4,5,6,7,9,10,11,15,16,17]

# array = [0,1,2,3,4,5,6,7,8,9,10,11,12]


tree = Tree.new(array)
tree.pretty_print
# p  tree.find_parent(3).data
# p tree.find_parent(2)

tree.delete(15)
# p tree.find(1)&.data

tree.pretty_print


# p tree.sucessor(tree.root).data
# p tree.pretty_print


# p tree.root.left.left.right