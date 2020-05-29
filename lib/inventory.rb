class Inventory
  attr_reader :line_items

  def initialize(line_items)
    @line_items = line_items
  end
end
