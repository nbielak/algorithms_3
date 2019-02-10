require_relative 'heap'
require_relative 'heap'

def k_largest_elements(array, k)
    prc = Proc.new{|x, y| x <=> y}
    heap = BinaryMinHeap.new(&prc)
    res = []
    array.each do |el|
        heap.push(el)
    end

    array.length.times do
        res << heap.extract
    end
    res[array.length - k...array.length]
end
