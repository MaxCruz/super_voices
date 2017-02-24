class ChangeStartEndColumnInContest < ActiveRecord::Migration[5.0]
  def change
      rename_column :contests, :start, :start_date
      rename_column :contests, :end, :end_date
  end
end
