class CreateSheets < ActiveRecord::Migration[6.0]
  def change
    create_table :sheets do |t|
      t.string :name, null: false
      t.belongs_to :phenotype, index: true
      t.belongs_to :cultivation, index: true

      t.timestamps
    end
  end
end
