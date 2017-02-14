class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :pro_enabled, :default => false
      t.string :key
      t.timestamps
    end
  end
end
