class CreateStages < ActiveRecord::Migration[6.0]
  def change
    create_table :stages do |t|
      t.string :type, null: false
      t.belongs_to :sheet, index: true
      t.date :start_date, null: false
      t.date :end_date
      t.date :estimated_end_date

      t.timestamps
    end
  end
end
