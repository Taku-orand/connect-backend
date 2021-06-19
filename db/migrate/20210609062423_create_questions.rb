class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.integer :like
      t.integer :student_id
      t.boolean :status
      t.boolean :anonymous

      t.timestamps
    end
  end
end
