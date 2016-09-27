class AddColumnsToUser < ActiveRecord::Migration
  def change
  	enable_extension 'hstore'
  	add_column :users, :event_date, :datetime
  	add_column :users, :location, :string
  	add_column :users, :event_money_spent, :hstore
  	add_column :users, :event_name, :string
  	#add_column :users, :location, :string

  end
end
