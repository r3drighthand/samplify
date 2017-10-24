class Track < ApplicationRecord
  belongs_to :sampler
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>"}, default_url: "/images/:style/missing.png"

  validates_presence_of :name, :sampler_id
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
