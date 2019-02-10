require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new{|x, y| x <=> y}
    heap = BinaryMinHeap.new(&prc)
    
    self.each do |el|
      heap.push(el)
    end

    (0...self.length).each do |i|
      self[i] = heap.extract
    end
    self
  end
end
