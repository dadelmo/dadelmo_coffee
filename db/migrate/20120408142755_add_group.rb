class AddGroup < ActiveRecord::Migration
  def self.up
  	add_column :users, :group, :type => [:admin, :user]

  end

  def self.down
    drop_column :users, :group
  end
end
