class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items
  has_many :order_items

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  scope :search, -> (query) { where('name ILIKE ?', "%#{query}%") }
end