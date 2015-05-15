class Match < ActiveRecord::Base

  belongs_to :game
  belongs_to :product
  # Remember to create a migration!
end
