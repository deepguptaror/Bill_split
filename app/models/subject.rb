class Subject < ActiveRecord::Base
	belongs_to :user
	has_many :image_stores, as: :image
end
