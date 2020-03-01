class CreateCouses < ActiveRecord::Migration[6.0]
  def change
    create_table :couses do |t|
      t.string :name
      t.text :description
      t.integer :time_training

      t.timestamps
    end
  end
end
