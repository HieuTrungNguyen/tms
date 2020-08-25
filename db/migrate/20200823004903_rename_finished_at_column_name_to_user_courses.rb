class RenameFinishedAtColumnNameToUserCourses < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_courses, :finished_at, :finished
  end
end
