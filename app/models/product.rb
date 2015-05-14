class Product < ActiveRecord::Base
  has_many :descriptions
  # Remember to create a migration!
end
