class CreateCompanyContests < ActiveRecord::Migration[5.0]
  def change
    create_table :company_contests do |t|
      t.string :name
      t.string :image
      t.string :url
      t.datetime :start
      t.datetime :end
      t.decimal :payment
      t.text :script
      t.text :guidelines
      t.integer :company_administrator_id

      t.timestamps
    end
  end
end
