require 'open-uri'
require 'csv'

class Event < ActiveRecord::Base
    has_many :races, dependent: :destroy
    @@HEADERS = "bib_number,first_name,last_name,gun_start,chip_start,split_1,split_2,split_3,split_4,split_5,split_6,split_7,split_8,split_9,split_10,adjustment_time,finish_time,gun_elapsed_time,chip_elapsed_time,age,division,gender,city,state,team_name,team_order,sms_phone,email,chip_number,user_field_1,user_field_2,user_field_3,unique_id,photo_files\r\n"

    def import
        self.save if !self.id
        url = self.import_path + '?dl=1' if self.import_path.split('?').length != 2
        url_data = @@HEADERS + open(url).read
        csv = CSV.new(url_data, headers: true).to_a.map { |row| row.to_hash }
        self.create_entries(csv)
    end

    def create_entries(csv)
        self.races.each { |race| race.entries.each { |entry| entry.destroy } }
        csv.each do |entry_attrs|
            entry = Entry.new(entry_attrs)
            entry.race = self.races.find_by_division(entry.division)
            entry.save
            self.create_splits(entry)
        end
    end

    def create_splits(entry)
        #use split template to create these
        if entry.race
            entry.race.split_templates.each do |template|
                length = (entry[template.diff_field_1].to_msec - entry[template.diff_field_2].to_msec).abs.to_race_time
                label  = template.label
                rate   = template.distance/length.to_msec*3600000.0
                entry.splits.create(time: entry[template.diff_field_2], distance: template.distance, length: length, label: label, rate: rate)
            end
        end
    end
end
