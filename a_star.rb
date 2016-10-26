require 'pry'
require_relative 'node_builder'

def a_star(start_node, end_node)
  open_list = [start_node] #discovered but not examined 
  closed_list = [] #discovered and examined
  current = start_node

  while open_list.length > 0
    if current == end_node
      return current_path(current)
    end

    current.siblings.each do |node|
      if !closed_list.include?(node)
        node.set_f_cost(start_node, end_node)
        node.came_from = current
        open_list.push(node)
      end
    end

    open_list.delete(current)

    open_list.sort! do |x, y|
      x.f_cost <=> y.f_cost
    end

    closed_list.push(current)

    current = open_list.first
  end
end

def current_path(node)
  node_path_array = [node]

  while node.came_from
    node = node.came_from
    node_path_array.push(node)
  end

  node_path_array
end


input = NodeBuilder.new(('a'..'z').to_a).node_array

start_node = input[0]
end_node = input[-1]

puts 'start node'
puts start_node.name
puts '----------'
puts 'end node'
puts end_node.name
puts '----------'

puts 'board'
input.map do |x| 
  x.set_f_cost(start_node, end_node)
  [x.name, x.f_cost]
end.each_slice(4).to_a.each do |row|
  puts row.inspect
end
puts '----------'

puts a_star(start_node, end_node).map{|x| x.name}.reverse.join(" -> ")
