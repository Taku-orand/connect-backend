class AddAnswerIdToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :answer_id, :integer
  end
end
