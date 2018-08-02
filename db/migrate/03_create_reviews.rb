class CreateReviews < ActiveRecord::Migration[4.2]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :text
      t.integer :customer_id
      t.integer :restaurant_id
    end
  end
end
