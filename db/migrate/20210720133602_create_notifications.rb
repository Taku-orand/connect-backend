class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
      create_table :notifications do |t|
        t.integer :visitor_id, null: false
        t.integer :visited_id, null: false
        t.integer :question_id
        t.string :visitor_name, default: '', null: false
        t.string :answer, default: '', null: false
        t.boolean :checked, default: false, null: false
        t.timestamps
      end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :question_id
  end
end
