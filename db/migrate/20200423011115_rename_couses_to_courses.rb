class RenameCousesToCourses < ActiveRecord::Migration[6.0]
  def change
    rename_table :couses, :courses
  end
end
