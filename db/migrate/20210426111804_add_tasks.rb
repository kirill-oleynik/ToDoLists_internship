class AddTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :title
      t.boolean :done
      t.datetime :deadline
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
