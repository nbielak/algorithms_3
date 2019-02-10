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
    BinaryMinHeap.heapify_down(@store, 0, self.count)
    res
  end

  def peek
    @store
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, @store.length - 1, self.count, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    [2 * parent_index + 1, 2 * parent_index + 2].select{|idx| idx < len}
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new{|x, y| x <=> y}
    parent = array[parent_idx]

    children_idx = BinaryMinHeap.child_indices(len, parent_idx)
    children = children_idx.map{|idx| array[idx]}
    sorted = children.sort(&prc)
    return array if children_idx.empty?

    if prc.call(parent, sorted[0]) > -1
      child_idx = children_idx[children.index(sorted[0])]
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      return BinaryMinHeap.heapify_down(array, child_idx, len, &prc)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx.zero?

    prc ||= Proc.new{|x, y| x <=> y}
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    parent = array[parent_idx]
    child = array[child_idx]

    if prc.call(parent, child) > -1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      return BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)
    end
    array
  end
end