class Whalewatch < ApplicationRecord
  belongs_to :user

  has_many :oservations, :dependent => :destroy

  validates :date, presence: true
  validates :place, presence: true
end
