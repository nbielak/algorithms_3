class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    res = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, self.count, &prc)
    res
  end

  def peek
  end

  def push(val)
    @store << val
    # parent_idx = BinaryMinHeap.parent_index(-1)
    BinaryMinHeap.heapify_up(@store, @store.length - 1, self.count, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    first_child_idx = (2 * parent_index) + 1
    second_child_idx = (2 * parent_index) + 2
    result = []

    result << first_child_idx if first_child_idx < len
    result << second_child_idx if second_child_idx < len

    result
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new{ |x, y| x <=> y}
    parent = array[parent_idx]

    children = BinaryMinHeap.child_indices(len, parent_idx)
    children_val = children.map{|child| array[child]}
    sorted = children_val.sort(&prc)
    return array if children.empty?
  
    if prc.call(parent, sorted[0]) > -1
      child_idx = children[children_val.index(sorted[0])]
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      return BinaryMinHeap.heapify_down(array, child_idx, len, &prc)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx.zero?

    prc ||= Proc.new{ |x, y| x <=> y}
    parent = BinaryMinHeap.parent_index(child_idx)
    child = array[child_idx]

    if prc.call(array[parent], child) > -1
      array[parent], array[child_idx] = array[child_idx], array[parent]
      return BinaryMinHeap.heapify_up(array, parent, len, &prc)
    end

    array

  end
end
