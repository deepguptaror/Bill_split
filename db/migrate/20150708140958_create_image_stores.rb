class CreateImageStores < ActiveRecord::Migration
  def change
    create_table :image_stores do |t|
      t.integer :image_id
      t.string :image_type

      t.timestamps null: false
    end
  end
end
