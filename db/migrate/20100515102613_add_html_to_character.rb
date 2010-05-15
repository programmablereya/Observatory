class AddHtmlToCharacter < ActiveRecord::Migration
  def self.up
    add_column :characters, :descriptionHTML, :text
  end

  def self.down
    remove_column :characters, :descriptionHTML
  end
end
