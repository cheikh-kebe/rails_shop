class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :adress
      t.decimal :total_price, precision: 10, scale: 2
      t.string :customer_stripe_id
      
      t.belongs_to :user
      t.belongs_to :cart

      t.timestamps
    end
  end
end
