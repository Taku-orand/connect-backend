class ChangeDatatypeContentOfAnswers < ActiveRecord::Migration[6.1]
  def change
    change_column :answers, :content, :text
  end
end
