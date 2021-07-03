class AddAnswerIdToLike < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :answer_id, :integer
  end
end
