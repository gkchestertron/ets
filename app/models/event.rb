require 'open-uri'
require 'csv'

class Event < ActiveRecord::Base
    extend AccessImport
    mount_uploader :cover_photo, CoverPhotoUploader
    @@DBHEADERS = "bib_number,first_name,last_name,gun_start,chip_start,split_1,split_2,split_3,split_4,split_5,split_6,split_7,split_8,split_9,split_10,adjustment_time,finish_time,gun_elapsed_time,chip_elapsed_time,age,division,gender,city,state,team_name,team_order,sms_phone,email,chip_number,user_field_1,user_field_2,user_field_3,unique_id,photo_files\r\n"
    
    @@DIVISION_HEADERS = "its_id,division,group_page,lap_count\r\n"

    @@GROUP_HEADERS    = "m_line,f_line,m_description,m_bottom_age,m_top_age,f_description,f_bottom_age,f_top_age\r\n"
    
    @@DEFAULT_HEADERS  = "m_top_exclusions,f_top_exclusions,m_masters_age_start,f_masters_age_start,m_masters_inclusions,f_masters_inclusions,m_grand_masters_age_start,f_grand_masters_age_start,m_grand_masters_inclusions,f_grand_masters_inclusions,m_senior_masters_age_start,f_senior_masters_age_start,m_senior_masters_inclusions,f_senior_masters_inclusions\r\n"

    has_many :races, dependent: :destroy
    has_many :assoc_contact_events
    has_many :event_contacts, through: :assoc_contact_events
    belongs_to :timer
    belongs_to :event_group
    belongs_to :event_type
    belongs_to :billing_contact, class_name: "EventContact"


    def import
        self.import_folder
        self.save
        self.import_races
        self.import_groups
        self.import_database
    end
    
    def update_entries
        self.import_database
    end

    def import_folder
        url = self.import_path
        html = open(url).read
        links = html.scan(/<a.+?href="(https.+?)"/).flatten.uniq
        self.database_file_path = links.find { |link| /Database/ =~ link }
        self.division_file_path = links.find { |link| /Division/ =~ link }
        self.group_file_path = links.find { |link| /Group/ =~ link }
    end

    def import_database
        url_data = self.import_file('database_file_path', @@DBHEADERS)
        csv = CSV.new(url_data, headers: true).to_a.map { |row| row.to_hash }
        self.create_entries(csv)
    end

    def import_races
        self.races.each { |race| race.destroy }
        url_data = self.import_file('division_file_path', @@DIVISION_HEADERS)
        csv = CSV.new(url_data, headers: true).to_a.map { |row| row.to_hash }
        csv.each do |race_attrs|
            next if race_attrs['division'] === " " || !race_attrs['division']
            self.races.create(division: race_attrs['division'], group_page: race_attrs['group_page'])
        end
    end

    def import_groups
        @pages = [
            { page: 'A', groups: [] },
            { page: 'B', groups: [] },
            { page: 'C', groups: [] },
            { page: 'D', groups: [] },
            { page: 'E', groups: [] },
            { page: 'F', groups: [] },
            { page: 'G', groups: [] }
        ]

        url = self.group_file_path.split('?')[0] + '?dl=1'
        lineArray = open(url).read.split("\r\n")
        group_string   = @@GROUP_HEADERS   + lineArray[0..181].join("\r\n")
        default_string = @@DEFAULT_HEADERS + lineArray[182..-2].join("\r\n")
        self.create_groups(group_string)
        self.create_defaults(default_string)
    end

    def create_defaults(default_string)
        csv = CSV.new(default_string, headers: true).to_a.map { |row| row.to_hash }
        csv.each_with_index do |default_attrs, index|
            self.races.where(group_page: @pages[index][:page]).each do |race|
                race.group_defaults.create(
                    gender: 'M',
                    top_exclusions: default_attrs['m_top_exclusions'],
                    masters_age_start: default_attrs['m_masters_age_start'],
                    masters_inclusions: default_attrs['m_masters_inclusions'],
                    grand_masters_age_start: default_attrs['m_grand_masters_age_start'],
                    grand_masters_inclusions: default_attrs['m_grand_masters_inclusions'],
                    senior_masters_age_start: default_attrs['m_senior_masters_age_start'],
                    senior_masters_inclusions: default_attrs['m_senior_masters_inclusions']
                )
                race.group_defaults.create(
                    gender: 'F',
                    top_exclusions: default_attrs['f_top_exclusions'],
                    masters_age_start: default_attrs['f_masters_age_start'],
                    masters_inclusions: default_attrs['f_masters_inclusions'],
                    grand_masters_age_start: default_attrs['f_grand_masters_age_start'],
                    grand_masters_inclusions: default_attrs['f_grand_masters_inclusions'],
                    senior_masters_age_start: default_attrs['f_senior_masters_age_start'],
                    senior_masters_inclusions: default_attrs['f_senior_masters_inclusions']
                )
            end
        end
    end

    def create_groups(group_string)
        csv = CSV.new(group_string, headers: true).to_a.map { |row| row.to_hash }
        i = 0
        csv.each do |group_attrs|
            i = 0 if i > 6
            @pages[i][:groups].push(group_attrs)
            i += 1
        end
        @pages.each do |page|
            races = self.races.where(group_page: page[:page]).each do |race|
                page[:groups].each do |group_attrs|
                    next if group_attrs['m_bottom_age'] === "0"
                    race.groups.create(
                        gender: 'M', 
                        description: group_attrs['m_description'],
                        bottom_age: group_attrs['m_bottom_age'],
                        top_age: group_attrs['m_top_age']
                    )
                    race.groups.create(
                        gender: 'F', 
                        description: group_attrs['f_description'],
                        bottom_age: group_attrs['f_bottom_age'],
                        top_age: group_attrs['f_top_age']
                    )
                end
            end
        end
    end

    def import_file(file_path, headers)
        url = self[file_path].split('?')[0] + '?dl=1'        
        headers + open(url).read
    end
    
    def create_entries(csv)
        self.races.each { |race| race.entries.each { |entry| entry.destroy } }
        csv.each do |entry_attrs|
            entry = Entry.new(entry_attrs)
            entry.bib_number = 1 if entry.bib_number == 0 #wtf?
            entry.race = self.races.find_by_division(entry.division) ||
                         self.races.new(division: entry.division)
            entry.save
            self.create_splits(entry)
        end
    end

    def create_splits(entry)
        #use split template to create these
        if entry.race
            entry.race.split_templates.each do |template|
                ['diff_field_1', 'diff_field_2'].each do |diff|
                    if template[diff] == 'start_time'
                        entry.chip_start == "0" ? template[diff] = 'gun_start' : template[diff] = 'chip_start' 
                    end
                end
                diff_1 = entry[template.diff_field_1].to_msec
                diff_2 = entry[template.diff_field_2].to_msec
                if diff_1 > 0 && diff_2 > 0
                    length = (diff_1 - diff_2).abs.to_race_time
                else
                    length = "N/A"
                end

                template.distance ||= 0
                label = template.label
                order = template.order || 0
                if template.distance
                    rate = template.distance/length.to_msec*3600000.0
                else
                    rate = 0
                end
                entry.splits.create(time: entry[template.diff_field_2], distance: template.distance, length: length, label: label, rate: rate, order: order)
            end
        end
    end
end
