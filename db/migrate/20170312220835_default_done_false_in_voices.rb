class DefaultDoneFalseInVoices < ActiveRecord::Migration[5.0]
  def change
      change_column :voices, :done, :boolean, :default => false
  end
end
