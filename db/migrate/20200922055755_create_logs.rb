class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.belongs_to :stage, index: true
      t.datetime :entry, null: false
      t.text :data
      t.integer :height
      t.boolean :feeded
      t.boolean :trained
      t.boolean :pruned

      t.timestamps
    end
  end
end
