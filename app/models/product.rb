class Product < ActiveRecord::Base

  attr_accessible :name, :price

  has_many :lineitems

  validates :name, :presence => true, :uniqueness => true  #uniqueness verifies there is only one in the table
  validates :price, :presence => true, :numericality => true  #validates price is a number found on rails.doc

end
