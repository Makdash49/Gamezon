class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.float :player1_guess
      t.float :player2_guess
      t.integer :winner
      t.integer :game_id

      t.timestamps
    end
  end
end
