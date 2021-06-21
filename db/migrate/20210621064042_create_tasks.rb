class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :discription
      t.integer :priority
      t.date :deadline
      t.integer :status

      t.timestamps
    end
  end
end
