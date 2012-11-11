class LineItem < ActiveRecord::Base

  attr_accessible :price, :product, :quantity

  #belongs_to :cart
  belongs_to :itemable, :polymorphic => true
  belongs_to :product
  #belongs_to :cart

  before_create :save_price

  def total_cents
    quantity * price
  end

  def name
    product.name
  end

  private

  def save_price
    self.price = product.price
  end

end
