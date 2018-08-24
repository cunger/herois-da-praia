class Cleanup < ApplicationRecord
  belongs_to :user
  has_many :items

  attr_reader :date, :place

  def items
    [] # TODO Item.where('cleanup_id = #{id}')
  end

  module Place
    def self.Guinjata
      'guinjata'
    end

    def self.GuinjataPoint
      'guinjata_point'
    end

    def self.Paindane
      'paindane'
    end

    def self.Other
      'other'
    end
  end
end
