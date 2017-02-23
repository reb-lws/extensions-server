# This migration comes from collab (originally 20170222133537)
class CreateCollabDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :collab_documents do |t|
      t.text :content
      t.string :iv
      t.string :auth
      t.string :uuid
      t.timestamps
    end
  end
end
