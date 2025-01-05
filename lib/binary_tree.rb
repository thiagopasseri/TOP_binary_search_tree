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
    node = find(value)
    sucessor_node = sucessor(node)

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
      delete(sucessor_node.data) 
      node.data = sucessor_node_data  
    end
  end

  def level_order_iterative
    current_node = @root
    queue = [current_node]
    process_array = []
    while(queue.any?)
      current_node = queue.pop
      if block_given?
        yield current_node 
      else   
       process_array << current_node.data
      end
      queue.unshift(current_node.left) if current_node.left 
      queue.unshift(current_node.right) if current_node.right 
    end
    return process_array unless block_given?
    nil
  end

  def level_order_recursive(queue =[@root], &block)

    current_node = queue.pop
    return nil if current_node.nil?
    yield current_node if block_given?
    queue.unshift(current_node.left)
    queue.unshift(current_node.right)

    level_order_recursive(queue, &block ) unless current_node.left.nil?
    level_order_recursive(queue, &block) unless current_node.right.nil?
  end

  def in_order(current_node = @root, array = [], &block)
    # return nil if current_node.nil?

    in_order(current_node.left, array, &block ) unless current_node.left.nil?
    yield current_node if block_given?
    array << current_node.data
    in_order(current_node.right,array, &block) unless current_node.right.nil?
    return array unless block_given?
    return nil if block_given?
  end

  def pre_order(current_node = @root, array = [], &block)
    return nil if current_node.nil?
    yield current_node if block_given?
    array << current_node.data
    pre_order(current_node.left, array, &block ) unless current_node.left.nil?
    pre_order(current_node.right, array, &block) unless current_node.right.nil?
    return array unless block_given?
    return nil if block_given?
  end

  def post_order(current_node = @root, array = [], &block)
    post_order(current_node.left, array, &block ) unless current_node.left.nil?
    post_order(current_node.right, array, &block) unless current_node.right.nil?
    yield current_node if block_given?
    array << current_node.data
    return array unless block_given?
    return nil if block_given?
  end
  
  def height(node = @root, height = 0)
    current_node = node
    return 0 if current_node.nil?
    if current_node.is_leaf?
      return height
    else
      return 1 + [height(current_node.left), height(current_node.right)].max
    end
  end

  def depth(value)
    current_node = @root
    queue = [current_node]
    process_array = []
    while(queue.size != 0)
      current_node = queue.pop
      if block_given?
        yield current_node 
      else   
       process_array << current_node.data if current_node
       process_array << current_node if current_node.nil?
      end
      queue.unshift(current_node&.left) if current_node
      queue.unshift(current_node&.right) if current_node
    end
    n = process_array.find_index(value)
    return nil if n.nil?
    h = Math.log2(n+1).floor
    # return process_array unless block_given?
    return h
  end

  def balanced?
    return true if (height(@root.left) - height(@root.right)).abs <= 1
    false
  end
end