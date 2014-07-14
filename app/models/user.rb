class User < ActiveRecord::Base
	has_many :entries
	has_many :races, through: :entries

#function that returns object with all its associated objects (or at least a representation of them with a single query)
	def self.get(id)
#make return all the rows associated with all of them (probably need to use user_id instead of user.id - somehow get all the rows)
		attrs = [self.new.attributes.keys.map { |attr| "#{self.to_s.underscore.pluralize}.#{attr} AS #{self.to_s.underscore}_#{attr}" }]
		self.reflect_on_all_associations.map(&:name).each do |name|
			attrs += name.to_s.camelize.singularize.constantize.new.attributes.keys.map { |attr| "#{name}.#{attr} AS #{name.to_s.singularize}_#{attr}" }
		end
		columns = attrs.join(', ')
		join = nil #build join from names 
		flat_obj = self.find_by_sql(["SELECT #{columns} FROM users JOIN entries ON user_id JOIN races ON race_id WHERE users.id = ?", id])[0]
	end
end
