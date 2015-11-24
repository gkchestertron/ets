class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_type_id, :integer
    add_column :events, :website, :string
    add_column :events, :street, :string
    add_column :events, :city, :string
    add_column :events, :state, :string
    add_column :events, :zip, :string
    add_column :events, :number_of_participants, :integer
    add_column :events, :online_registration_link, :string
    add_column :events, :billing_contact_id, :integer
    add_column :events, :notes, :string
    add_column :events, :results_url, :string
    add_column :events, :course_map_url, :string
    add_column :events, :timer_id, :integer
    add_column :events, :event_group_id, :integer
    add_column :events, :is_visible, :boolean

    create_table :timers do |t|
      t.string :name
      t.string :url
      t.string :phone
      t.string :equipment
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
    end

    create_table :event_groups do |t|
      t.string :name
      t.integer :contact_id
    end
    
    create_table :event_types do |t|
      t.string :name
    end

    create_table :contacts do |t|
      t.string :company_name
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :email
      t.string :phone
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.text   :notes
    end

    create_table :assoc_contact_event do |t|
      t.integer :contact_id
      t.integer :event_id
      t.boolean :contact_is_primary
    end
  end
end
