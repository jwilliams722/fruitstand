class Cart < ActiveRecord::Base

  # attr_accessible :title, :body

  has_many :line_items, :as => :itemable, dependant: :destroy

  def total_cents
    lineitems.sum(&:total) #sum the total of the lineitems
  end

end
