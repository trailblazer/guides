class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :type
      t.integer :user_id
      t.integer :record_id

      t.timestamps
    end
  end
end
