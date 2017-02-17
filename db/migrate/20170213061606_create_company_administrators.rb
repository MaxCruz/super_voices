class CreateCompanyAdministrators < ActiveRecord::Migration[5.0]
  def change
    create_table :company_administrators do |t|
      t.string :names
      t.string :surnames
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
