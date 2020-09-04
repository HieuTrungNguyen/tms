class AddCoverToSubjects < ActiveRecord::Migration[6.0]
  def change
    add_column :subjects, :cover, :string
  end
end
