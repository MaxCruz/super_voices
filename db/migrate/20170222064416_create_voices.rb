class CreateVoices < ActiveRecord::Migration[5.0]
  def change
    create_table :voices do |t|
      t.date :creation
      t.string :email
      t.string :name
      t.string :last_name
      t.boolean :done
      t.text :message
      t.string :source_url
      t.string :destination_url

      t.timestamps
    end
  end
end
