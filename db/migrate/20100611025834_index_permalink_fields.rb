class IndexPermalinkFields < ActiveRecord::Migration
  def self.up
	add_index :tags, :permalink
	add_index :categories, :permalink
	add_index :relationships, :permalink
  end

  def self.down
	remove_index :relationships, :permalink
	remove_index :categories, :permalink
	remove_index :tags, :permalink
  end
end
