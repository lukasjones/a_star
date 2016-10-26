require_relative 'node'

class NodeBuilder
  attr_accessor :node_array

  def initialize(array_of_names)
    @node_array = build_node_array(array_of_names)
  end

  def build_node_array(array_of_names)
    _node_array = build_nodes(array_of_names)
    link_siblings(_node_array)
  end

  def build_nodes(array_of_names)
    array = array_of_names.map do |name|
      Node.new(name)
    end.each_slice(4).to_a

    array.pop

    array
  end

  def get_position(row_index, col_index)
    [col_index * 10, row_index * 10]
  end

  def get_siblings(node_arr, row_index, col_index)
    node = node_arr[row_index][col_index]
    rows = [node_arr[row_index]]
    siblings = []

    if row_index > 0
      rows << node_arr[row_index - 1]
    end

    if row_index < node_arr.length - 1
      rows << node_arr[row_index + 1]
    end

    rows.each do |row|
      if col_index > 0
        siblings << row[col_index - 1]
      end
      
      if col_index < row.length - 1
        siblings << row[col_index + 1]
      end

      siblings << row[col_index] unless row[col_index] == node
    end

    siblings
  end

  def link_siblings(node_arr)
    node_arr.each_with_index do |row, row_index|
      row.each_with_index do |node, col_index|
        node.siblings = get_siblings(node_arr, row_index, col_index).flatten
        node.position = get_position(row_index, col_index)
      end
    end.flatten
  end
end
