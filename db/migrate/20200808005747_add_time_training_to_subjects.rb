class AddTimeTrainingToSubjects < ActiveRecord::Migration[6.0]
  def change
    add_column :subjects, :time_training, :ingeter
  end
end
