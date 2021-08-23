class RemoveLikeFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :like_id, :integer
  end
end
