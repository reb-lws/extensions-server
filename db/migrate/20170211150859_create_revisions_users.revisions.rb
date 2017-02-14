# This migration comes from revisions (originally 20170211001350)
class CreateRevisionsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :revisions_users do |t|
      t.string :key
      t.timestamps
    end
  end
end
