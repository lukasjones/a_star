class Node
  attr_accessor :siblings, :name, :came_from, :position, :g_cost, :h_cost, :f_cost

  def initialize(name)
    @position = nil
    @name = name
    @siblings = []
    @came_from = nil
    @g_cost = nil
    @h_cost = nil
    @f_cost = nil
  end

  def add_sibling(node)
    @siblings.push(node)
  end

  def set_f_cost(start_node, end_node)
    @f_cost = g_cost(start_node.position) + h_cost(end_node.position)
  end

  private

  def h_cost(end_node_position)
    distance_to(end_node_position)
  end

  def g_cost(start_node_position)
    distance_to(start_node_position)
  end


  def distance_to(p)
    Math.sqrt((@position[0] - p[0])**2 + (@position[1] - p[1])**2).floor
  end
end
