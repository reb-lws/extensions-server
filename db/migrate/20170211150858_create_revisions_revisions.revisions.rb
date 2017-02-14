# This migration comes from revisions (originally 20170211000426)
class CreateRevisionsRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :revisions_revisions do |t|
      t.text :content, :limit => 16.megabytes - 1
      t.string :enc_item_key
      t.string :auth_hash
      t.integer :item_id
      t.datetime :created_at, limit: 6
      t.datetime :updated_at, limit: 6
    end

    add_index :revisions_revisions, :item_id
    add_index :revisions_revisions, :created_at
  end
end
