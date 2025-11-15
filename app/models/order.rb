class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  validates :name, :email, :address, presence: true

  before_save :calculate_total

  def calculate_total
    self.total_price = order_items.sum('quantity * price')
  end
end