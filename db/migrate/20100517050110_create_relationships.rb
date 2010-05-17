class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :character_id
      t.integer :to_id
      t.integer :source_id
      t.string :name
      t.string :permalink

      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
