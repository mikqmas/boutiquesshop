class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :lineitems

  enum status: [:waiting_for_delivery, :on_its_way, :delivered]
end
