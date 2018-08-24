class User < ApplicationRecord
  has_many :cleanups

  attr_reader :name, :group

  def self.default
    User.find_or_create_by name: 'Momo'
  end

  def unsubmitted_cleanups
    Cleanup.where("user_id = #{id}")
           .where.not("submitted")
  end

  module Group
    module LTO
      def self.staff
        'lto_staff'
      end

      def self.volunteer
        'lto_volunteer'
      end
    end

    def self.visitor
      'visitor'
    end

    def self.resident
      'resident'
    end
  end
end
