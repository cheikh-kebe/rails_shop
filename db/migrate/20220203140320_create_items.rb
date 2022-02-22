class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.decimal :price, :default => 0
      t.string :image_url
      t.string :item_format
      

      t.timestamps
    end
  end
end
