class CreateCustomers < ActiveRecord::Migration[4.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :profile_url
      t.string :image_url
    end
  end
end
