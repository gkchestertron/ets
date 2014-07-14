class Entry < ActiveRecord::Base
	belongs_to :user
	belongs_to :race
    has_many :splits, dependent: :destroy
end
