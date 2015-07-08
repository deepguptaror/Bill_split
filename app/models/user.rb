class User < ActiveRecord::Base
	#self.table_name = "tbl"
	#self.primary_key = 'Id'
	has_many :subjects 
	has_many :image_stores, as: :image
end
