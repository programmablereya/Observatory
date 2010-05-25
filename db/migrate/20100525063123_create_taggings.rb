class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :object_id
      t.string :object_type

      t.timestamps
    end
  end

  def self.down
    drop_table :taggings
  end
end
