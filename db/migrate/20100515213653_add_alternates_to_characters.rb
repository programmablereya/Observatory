class AddAlternatesToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :parent_id, :integer
  end

  def self.down
    remove_column :characters, :parent_id
  end
end
