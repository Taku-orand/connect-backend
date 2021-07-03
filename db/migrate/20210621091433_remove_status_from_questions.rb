class RemoveStatusFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :status, :boolean
  end
end
