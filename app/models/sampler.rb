class Sampler < ApplicationRecord
  belongs_to :user
  has_many :tracks

  validates_presence_of :user_id, :title

  # before_save :set_samplify

  # private
  # def set_samplify
  #   self.samplified = false
  # end


end
