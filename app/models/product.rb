class Product < ActiveRecord::Base
  has_many :lineitems
  has_many :product_category
  has_many :categories, through: :product_category
end
