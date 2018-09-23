class Beachclean < ApplicationRecord
  belongs_to :user

  has_many :items, :dependent => :destroy

  validates :date, presence: true
  validates :uuid, presence: true
end
