class RemoveColumnsInQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :student_id, :integer
  end
end
