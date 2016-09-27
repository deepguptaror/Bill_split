class User < ActiveRecord::Base
	#self.table_name = "tbl"
	#self.primary_key = 'Id'
	has_many :subjects 
	has_many :images, as: :image

	def self.user_event
		{'dinner' => 'dinner', 'lunch' => 'lunch', 'breakfast' => 'breakfast'}
	end

end
