class CreateCouses < ActiveRecord::Migration[6.0]
  def change
    create_table :couses do |t|
      t.string :name
      t.text :description
      t.integer :time_training, default: 0, null: false

      t.timestamps
    end
  end
end
