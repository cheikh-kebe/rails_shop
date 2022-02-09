class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.integer :quantity, :default =>  1
      t.belongs_to :item
      t.belongs_to :cart
      t.belongs_to :order


      t.timestamps
    end
  end
end
