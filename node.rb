class Node
  attr_accessor :siblings, :name, :came_from, :position

  def initialize(name)
    @position = nil
    @name = name
    @siblings = []
    @came_from = nil
  end

  def add_sibling(node)
    @siblings.push(node)
  end
end
