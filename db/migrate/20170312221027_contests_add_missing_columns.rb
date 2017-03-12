class ContestsAddMissingColumns < ActiveRecord::Migration[5.0]
  def change
      add_column :contests, :script, :text
      add_column :contests, :recomendations, :text
      change_column :contests, :reward, 'integer USING CAST(reward AS integer)'
  end
end
