class AddS3UrlToSamplers < ActiveRecord::Migration[5.1]
  def change
    add_column :samplers, :s3_url, :string, default: nil
  end
end
