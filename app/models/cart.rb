class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def total_price
    line_items.joins(:product).sum('line_items.quantity * products.price')
  end
end