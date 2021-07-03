class AddQuestionIdToLike < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :question_id, :integer
  end
end
