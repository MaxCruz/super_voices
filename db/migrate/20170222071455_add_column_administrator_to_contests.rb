class AddColumnAdministratorToContests < ActiveRecord::Migration[5.0]
  def change
    add_column :contests, :administrator_id, :int
  end
end
