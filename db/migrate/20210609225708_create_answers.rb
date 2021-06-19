class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.integer :student_id
      t.integer :question_id
      t.string :content
      t.integer :like
      t.boolean :anonymous

      t.timestamps
    end
  end
end
  