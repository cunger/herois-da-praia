class User < ApplicationRecord
  has_many :cleanups

  restrict_type_of :group, to: UserGroup

  def self.default
    User.find_or_create_by name: 'Momo'
  end

  def submitted_cleanups
    cleanups.where(submitted: true)
            .order(:date)
  end

  def unsubmitted_cleanups
    cleanups.where(submitted: false)
            .order(:date)
  end
end
