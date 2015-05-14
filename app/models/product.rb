class Product < ActiveRecord::Base
  has_many :descriptions

  validates :name, presence: true
  # Remember to create a migration!
end
