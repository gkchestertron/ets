class Race < ActiveRecord::Base
    belongs_to :event
	has_many :entries, dependent: :destroy
	has_many :users, through: :entries
    has_many :split_templates, dependent: :destroy
end
