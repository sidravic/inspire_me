class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column :post_id, :integer
      t.column :photo_title, :string
      t.column :photo_taken_with, :string
      t.column :photo_taken_on, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
