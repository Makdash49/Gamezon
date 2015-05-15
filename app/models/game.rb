class Game < ActiveRecord::Base

  has_many :matches
  # Remember to create a migration!
end
