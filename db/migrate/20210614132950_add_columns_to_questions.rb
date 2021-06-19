class AddColumnsToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :user, index: true
  end
end
