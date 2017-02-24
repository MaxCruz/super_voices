class DropInnecesaryTables < ActiveRecord::Migration[5.0]
  def change
      drop_table :active_admin_comments 
      drop_table :admin_users
      drop_table :company_administrators
  end
end
