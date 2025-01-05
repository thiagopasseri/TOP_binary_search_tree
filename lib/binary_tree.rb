class Tree
  attr_accessor :root

  def initialize(array = nil)
    @root = build_tree(array)
  end

  # abordagem recursiva
  def build_tree(array)
    return nil if array.empty? 

    mid_point = array.length/2

    node = Node.new(array[mid_point])
    node.left = build_tree(array[0..mid_point-1]) if mid_point != 0 #devido a sintaxse array[0..-1] que retorna o elemento unico ao inves de nil
    node.right = build_tree(array[(mid_point+1)..]) 
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node&.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node&.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node&.data}"
    pretty_print(node&.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node&.left
  end

  # abordagem iterativa // utilizar bluid_tree_loop(array) no initialize
  def build_tree_loop(array, left_index = 0, right_index = array.length - 1)
    return nil if array.nil?

    queue = []
    @root = Node.new
    queue << [@root, left_index, right_index]

    current_node = @root
    until queue.empty?
      current_node, left, right = queue.pop

      return nil if left > right

      mid = (left + right + 1)/2

      current_node.data = array[mid]
      
      # next if left == right
      if left == right
        current_node.left = nil 
        current_node.right = nil
        next
      end

      current_node.left = Node.new
      current_node.right = Node.new if mid + 1 <= right    #serve para não se criar um nó no ramo da direita que nao vai ser preenchido

      queue.unshift([current_node.left, left, mid - 1])
      queue.unshift([current_node.right, mid + 1, right])
    end
    @root

  end

  def insert(value)
    current_node = @root
    until (current_node.nil?)
      if value > current_node.data
        if current_node.right.nil?
          current_node.right = Node.new(value)
          return
        else
          current_node = current_node.right
        end
      else
        if current_node.left.nil?
          current_node.left = Node.new(value)
          return
        else
          current_node = current_node.left
        end
      end
    end
  end

  def find(value)
    current_node = @root
    queue = [current_node]

    while current_node&.data != value && !current_node.nil?
      current_node = queue.pop
      queue.unshift current_node.left unless current_node&.left.nil?
      queue.unshift current_node.right unless current_node&.right.nil?
    end
    current_node
  end

  def find_parent(value)
    current_node = @root
    queue = [current_node]

    until current_node.nil?
      current_node = queue.pop
      
      if current_node&.left&.data == value 
        return current_node, "left"
      elsif current_node&.right&.data == value 
        return current_node, "right"
      elsif !current_node&.left.nil? && !current_node&.right.nil?
        queue.unshift current_node.left
        queue.unshift current_node.right 
      end
    end
    nil
  end


  
  def sucessor(node)
    current_node = node&.right
    return node if current_node.nil?
    until current_node&.left.nil?
      current_node = current_node.left
    end
    current_node
  end

  def delete(value)
    parent, direction = find_parent(value)
    puts "parent: #{parent&.data}"
    node = find(value)
    puts "node : #{node.data}"
    sucessor_node = sucessor(node)

    puts "node: #{node.data} -> sucessor:#{sucessor_node.data}"
    sucessor_node_data = sucessor_node.data

    if node&.left.nil? && node&.right.nil?
    parent.left = nil if direction == "left"
    parent.right = nil if direction == "right" 
    
    elsif node.left.nil? ^ node.right.nil?
      parent.left = node.left if direction == "left" && !node.left.nil?
      parent.left = node.right if direction == "left" && !node.right.nil?

      parent.right = node.left if direction == "right" && !node.left.nil?
      parent.right = node.right if direction == "right" && !node.right.nil? 
    elsif node.right == sucessor_node     # base case of recursion
      node.right = sucessor_node.right
      node.data = sucessor_node.data
    else                                  # sucessor will have 1 child at maximum
      puts "sucessor to delete: #{sucessor_node.data}"
      delete(sucessor_node.data) 
      node.data = sucessor_node_data  
    end
  end

  

end