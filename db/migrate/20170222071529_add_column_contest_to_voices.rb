class AddColumnContestToVoices < ActiveRecord::Migration[5.0]
  def change
    add_column :voices, :contest_id, :int
  end
end
