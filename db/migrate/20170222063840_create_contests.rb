class CreateContests < ActiveRecord::Migration[5.0]
  def change
    create_table :contests do |t|
      t.string :name
      t.string :image
      t.string :url
      t.date :start
      t.date :end
      t.text :reward

      t.timestamps
    end
  end
end
