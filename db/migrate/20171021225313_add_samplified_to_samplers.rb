class AddSamplifiedToSamplers < ActiveRecord::Migration[5.1]
  def change
    add_column :samplers, :samplified, :boolean
  end
end
