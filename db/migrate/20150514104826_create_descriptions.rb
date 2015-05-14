class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.text :content
      t.integer :product_id

      t.timestamps
    end
  end
end
