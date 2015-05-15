class Description < ActiveRecord::Base
  belongs_to :product
  # Remember to create a migration!
end
