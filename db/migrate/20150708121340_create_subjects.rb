class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.integer :user_id
      t.string :name

      t.timestamps null: false
    end
  end
end
