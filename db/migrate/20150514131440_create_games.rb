class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :player1
      t.string :player2
      t.string :winner
      t.integer :player1_score, :default => 0
      t.integer :player2_score, :default => 0

      t.timestamps
    end
  end
end
