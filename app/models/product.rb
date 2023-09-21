class Product < ApplicationRecord
  has_one_attached :image

  has_many :cart_items
end
