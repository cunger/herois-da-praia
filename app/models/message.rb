class Message
  include ActiveModel::Model

  attr_accessor :name, :email, :text, :timestamp
  validates :name, :email, :text, presence: true
end
