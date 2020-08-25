class ChangeFinishedToBeIntegerInUserCourses < ActiveRecord::Migration[6.0]
  def up
    change_column :user_courses, :finished, :integer, default: 0, null: false
  end

  def down
    change_column :user_courses, :finished, :datetime
  end
end
