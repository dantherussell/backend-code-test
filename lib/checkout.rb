class Checkout
  attr_reader :discounts, :inventory
  private :discounts, :inventory

  def initialize(discounts, inventory)
    @discounts = discounts
    @inventory = inventory
  end

  def scan(item)
    basket << item.to_sym
  end

  def total
    total = 0

    basket.inject(Hash.new(0)) { |items, item| items[item] += 1; items }.each do |item, count|
      discount = discounts.items[item]
      line_item = inventory.line_items[item]
      if discount
        at_offer_price = (discount[:limit] && count >= discount[:limit]) ? discount[:limit] : (count / discount[:count])
        count = count - (at_offer_price * discount[:count])
        total += discount[:price] * at_offer_price
      end

      total += line_item * count
    end

    total
  end

  private

  def basket
    @basket ||= Array.new
  end
end
