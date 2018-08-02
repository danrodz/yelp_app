class CreateRestaurants < ActiveRecord::Migration[4.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :image_url
      t.string :categories
      t.integer :rating
      t.string :address
      t.string :yelp_id
    end
  end
end
