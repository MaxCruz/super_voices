class RemoveCreationInVoices < ActiveRecord::Migration[5.0]
  def change
      remove_column :voices, :creation
  end
end
