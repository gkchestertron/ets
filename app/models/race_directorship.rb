class RaceDirectorship < ActiveRecord::Base
	belongs_to :user
	belongs_to :race
end
