class AddTextIdToCharacter < ActiveRecord::Migration
  def self.up
    add_column :characters, :textid, :string
    add_index :characters, :textid
  end

  def self.down
    remove_index :characters, :textid
    remove_column :characters, :textid
  end
end
