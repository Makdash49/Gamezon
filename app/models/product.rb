class Product < ActiveRecord::Base
  has_many :descriptions
  has_many :matches

  validates :name, presence: true
  # Remember to create a migration!
end
