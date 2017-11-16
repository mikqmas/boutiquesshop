class Customer < ActiveRecord::Base
  has_many :orders

  validates :name, presence: true

  def self.ormQuery(category = 'Bouquets', customer = 'John')
    count = 0
    cat = Category.find_by_name(category) #'Bouquets', 'John'
    Customer.find_by_name(customer).orders.all.each{|order| count += order.lineitems.select{|li| li.product.categories.include?(cat)}.count}
    count
  end

  def self.sqlQuery(category = 'Bouquets', customer = 'John')
    query = <<-SQL
      SELECT c.id AS customer_id,
      c.name AS customer_first_name,
      cat.id AS category_id,
      cat.name AS category_name,
      COUNT(li.id) AS number_purchased
      FROM customers AS c
      JOIN orders AS o on c.id = o.customer_id
      JOIN lineitems AS li on o.id = li.order_id
      JOIN products AS p on li.product_id = p.id
      JOIN product_categories AS prodcat on prodcat.product_id = p.id
      JOIN categories AS cat on cat.id = prodcat.category_id
      WHERE cat.name = 'Bouquets' AND c.name = 'John';
    SQL

    result = ActiveRecord::Base.connection.execute(query)
  end
end
