class ModifyTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :mark, :string, :default => "Undone"
    add_column :tasks, :body, :text
  end
end
