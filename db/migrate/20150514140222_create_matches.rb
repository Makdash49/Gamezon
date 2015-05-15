class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.float :player1_guess
      t.float :player2_guess
      t.integer :game_id
      t.integer :product_id
      t.string :winner_message

      t.timestamps
    end
  end
end
