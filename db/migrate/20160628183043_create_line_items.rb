class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :order, index: true, foreign_key: true
      t.string :product
      t.integer :qty
      t.decimal :unit_price
      t.decimal :full_price
      t.timestamps null: false
    end
  end
end
