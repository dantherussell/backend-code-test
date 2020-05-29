class Checkout
  attr_reader :inventory
  private :inventory

  def initialize(inventory)
    @inventory = inventory
  end

  def scan(item)
    basket << item.to_sym
  end

  def total
    total = 0

    basket.inject(Hash.new(0)) { |items, item| items[item] += 1; items }.each do |item, count|
      if item == :apple || item == :pear
        if (count % 2 == 0)
          total += inventory.line_items.fetch(item) * (count / 2)
        else
          total += inventory.line_items.fetch(item) * count
        end
      elsif item == :banana || item == :pineapple
        if item == :pineapple
          total += (inventory.line_items.fetch(item) / 2)
          total += (inventory.line_items.fetch(item)) * (count - 1)
        else
          total += (inventory.line_items.fetch(item) / 2) * count
        end
      elsif item == :mango
        count_for_free = count / 4
        count_to_pay_for = count - count_for_free
        total += inventory.line_items.fetch(item) * count_to_pay_for
      else
        total += inventory.line_items.fetch(item) * count
      end
    end

    total
  end

  private

  def basket
    @basket ||= Array.new
  end
end
