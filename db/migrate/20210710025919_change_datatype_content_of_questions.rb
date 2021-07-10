class ChangeDatatypeContentOfQuestions < ActiveRecord::Migration[6.1]
  def up
    change_column :questions, :content, :text
  end
end
