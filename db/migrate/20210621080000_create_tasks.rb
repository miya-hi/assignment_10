class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.date :deadline, null: false, default: ''


      t.timestamps
    end
  end
end
