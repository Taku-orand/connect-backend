class AddColumnsToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :user, index: true
    add_reference :answers, :question, index: true
  end
end
