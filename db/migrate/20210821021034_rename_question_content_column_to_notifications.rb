class RenameQuestionContentColumnToNotifications < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :question_content, :question_title
  end
end
