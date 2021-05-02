class AddCommentsToTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.string :title
      t.references :task, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
