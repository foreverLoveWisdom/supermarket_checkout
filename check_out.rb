# frozen_string_literal: true

require 'pry-byebug'

# frozen_string_literal: true

# Handle the checkout process
class CheckOut
  attr_reader :total

  ITEMS = %w[A B C D].freeze

  def initialize(pricing_rules = default_pricing_rules)
    @pricing_rules = pricing_rules
    @item_counts = Hash.new(0)
    @total = 0
  end

  def scan(item)
    return unless ITEMS.include?(item)

    @item_counts[item] += 1
    update_total
  end

  private

  attr_reader :pricing_rules, :item_counts

  def default_pricing_rules
    {
      'A' => 50,
      'B' => 30,
      'C' => 20,
      'D' => 15,
      special_prices: {
        'A' => { quantity: 3, price: 130 },
        'B' => { quantity: 2, price: 45 }
      }
    }
  end

  def update_total
    @total = 0
    item_counts.each do |item, count|
      if special_price?(item) && count >= special_quantity(item)
        special_price_hanlder(item, count)
      else
        @total += regular_price(item) * count
      end
    end
  end

  def special_price_hanlder(item, count)
    @total += special_price(item) * (count / special_quantity(item))
    @total += regular_price(item) * (count % special_quantity(item))
  end

  def regular_price(item)
    pricing_rules[item]
  end

  def special_price(item)
    pricing_rules[:special_prices][item][:price]
  end

  def special_quantity(item)
    pricing_rules[:special_prices][item][:quantity]
  end

  def special_price?(item)
    pricing_rules[:special_prices][item]
  end
end
