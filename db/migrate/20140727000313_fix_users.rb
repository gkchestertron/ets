class FixUsers < ActiveRecord::Migration
  def change
      remove_column :users, :password
      add_column :users, :password_digest, :string
      add_column :users, :email, :string
  end
end
