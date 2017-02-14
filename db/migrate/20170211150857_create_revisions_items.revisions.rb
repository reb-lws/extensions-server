# This migration comes from revisions (originally 20170211000200)
class CreateRevisionsItems < ActiveRecord::Migration[5.0]
  def change
    create_table :revisions_items do |t|
      t.string :item_uuid, limit: 36, null: false
      t.string :content_type
      t.integer :user_id
      t.timestamps
    end

    add_index :revisions_items, :item_uuid
  end
end
