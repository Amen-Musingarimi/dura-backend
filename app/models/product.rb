class Product < ApplicationRecord
  has_one_attached :image

  has_many :cart_items, dependent: :destroy

  validates :name, presence: true, uniqueness: true 
  validates :english_name, presence: true, uniqueness: true
  validates_presence_of :description, :price, :measurement_unit, :total_units
end
