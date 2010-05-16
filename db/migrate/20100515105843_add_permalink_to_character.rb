class AddPermalinkToCharacter < ActiveRecord::Migration
  def self.up
    add_column :characters, :permalink, :string
    add_index :characters, :permalink
  end

  def self.down
    remove_index :characters, :permalink
    remove_column :characters, :permalink
  end
end
