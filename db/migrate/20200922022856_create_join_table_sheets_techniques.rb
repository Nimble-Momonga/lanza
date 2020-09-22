class CreateJoinTableSheetsTechniques < ActiveRecord::Migration[6.0]
  def change
    create_join_table :sheets, :techniques do |t|
      t.index [:sheet_id, :technique_id]
      t.index [:technique_id, :sheet_id]
    end
  end
end
